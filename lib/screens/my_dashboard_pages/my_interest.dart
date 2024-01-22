import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/my_interest_card.dart';
import '../../helpers/aiz_route.dart';
import '../../middleware/profile_view_middleware.dart';
import '../user_pages/user_public_profile.dart';
import 'interest_requests.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({Key? key}) : super(key: key);

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!store.state.userVerifyState!.isApprove!) {
      OneContext().pop();
      store.dispatch(
        ShowMessageAction(
          msg: "Please verify your account",
          color: MyTheme.failure,
        ),
      );
    } else {
      store.dispatch(Reset.myInterestList);
      store.dispatch(myInterestMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.myInterestState!.hasMore!) {
          store.dispatch(myInterestMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)!
                    .my_interest_screen_appbar_title)
            .build(context),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => NavigatorPush.push(context, const InterestRequest()),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: Const.kPaddingHorizontal),
                height: 45,
                width: DeviceInfo(context).width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: const Alignment(0.8, 1),
                    colors: [
                      MyTheme.gradient_color_1,
                      MyTheme.gradient_color_2,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)!
                      .my_interest_screen_request_interests,
                  style: Styles.bold_white_14,
                )),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            state.myInterestState!.isFetching!
                ? Expanded(child: CommonWidget.circularIndicator)
                : buildListViewSeparated(context, state)
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          store.dispatch(Reset.myInterestList);
          store.dispatch(myInterestMiddleware());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: state.myInterestState!.myInterestList!.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.myInterestState!.myInterestList!.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      state.myInterestState!.myInterestList![index] == null
                          ? Const.heightShrink
                          : Const.height15,
                  itemBuilder: (BuildContext context, int index) {
                    if (index ==
                        state.myInterestState!.myInterestList!.length) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: state.myInterestState!.hasMore!
                              ? CommonWidget.circularIndicator
                              : CommonWidget.noMoreData);
                    }
                    if (state.myInterestState!.myInterestList![index] == null) {
                      return Const.heightShrink;
                    }
                    return GestureDetector(
                      onTap: () {
                        AIZRoute.push(
                            context,
                            UserPublicProfile(
                              userId: state.myInterestState!
                                  .myInterestList![index].userId!,
                            ),
                            middleware: ProfileViewMiddleware(
                                context: context,
                                user: store.state.authState?.userData));
                      },
                      child: MyInterestCard(
                        photo:
                            state.myInterestState!.myInterestList![index].photo,
                        name:
                            state.myInterestState!.myInterestList![index].name,
                        status: state
                            .myInterestState!.myInterestList![index].status,
                        age: state.myInterestState!.myInterestList![index].age,
                        country: state
                            .myInterestState!.myInterestList![index].country,
                        religion: state
                            .myInterestState!.myInterestList![index].religion,
                        motherTongue: state.myInterestState!
                            .myInterestList![index].mothereTongue,
                      ),
                    );
                  },
                )
              : state.myInterestState!.fullReset!
                  ? Container()
                  : SizedBox(
                      height: DeviceInfo(context).height,
                      child: CommonWidget.noData,
                    ),
        ),
      ),
    );
  }
}

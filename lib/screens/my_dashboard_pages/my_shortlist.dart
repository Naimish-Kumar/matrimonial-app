import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/middleware/profile_view_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/shortlist_card.dart';
import '../../const/my_theme.dart';

class MyShortlist extends StatefulWidget {
  const MyShortlist({Key? key}) : super(key: key);

  @override
  State<MyShortlist> createState() => _MyShortlistState();
}

class _MyShortlistState extends State<MyShortlist> {
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
      store.dispatch(ShortListReset());
      store.dispatch(shortlistMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.shortlistState!.hasMore) {
          store.dispatch(shortlistMiddleware());
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
                    .my_shortlist_screen_appbar_title)
            .build(context),
        body: Column(
          children: [
            state.shortlistState!.isFetching == false
                ? buildListViewSeparated(context, state)
                : Expanded(child: CommonWidget.circularIndicator),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          store.dispatch(ShortListReset(payload: true));
          store.dispatch(shortlistMiddleware());
          return Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: state.shortlistState!.shortlistData!.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal,
                      vertical: Const.kPaddingVertical),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.shortlistState!.shortlistData!.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      state.shortlistState!.shortlistData![index] == null
                          ? Const.heightShrink
                          : Const.height15,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.shortlistState!.shortlistData!.length) {
                      if (state.shortlistState!.shortlistData![index] == null) {
                        return Const.heightShrink;
                      }
                      return GestureDetector(
                        onTap: () {
                          AIZRoute.push(
                              context,
                              UserPublicProfile(
                                userId: state.shortlistState!
                                    .shortlistData![index].userId!,
                              ),
                              middleware: ProfileViewMiddleware(
                                  context: context,
                                  user: store.state.authState?.userData));
                        },
                        child: ShortlistCard(
                          state: state,
                          index: index,
                          maincontext: maincontext,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: state.shortlistState!.hasMore
                            ? CommonWidget.circularIndicator
                            : CommonWidget.noMoreData,
                      );
                    }
                  },
                )
              : state.shortlistState!.fullReset!
                  ? Container()
                  : Visibility(
                      child: SizedBox(
                          height: DeviceInfo(context).height,
                          child: CommonWidget.noData),
                    ),
        ),
      ),
    );
  }
}

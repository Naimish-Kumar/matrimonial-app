import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/name_date_row.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_code_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_users_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Referral extends StatefulWidget {
  const Referral({Key? key}) : super(key: key);

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
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
      store.dispatch(Reset.referralUserList);
      store.dispatch(referralCodeMiddleware());
      store.dispatch(referralUsersMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.referralState!.hasMore!) {
          store.dispatch(referralCodeMiddleware());
          store.dispatch(referralUsersMiddleware());
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
        appBar:
            CommonAppBar(text: AppLocalizations.of(context)!.referral_screen)
                .build(context),
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
              child: buildReferralCode(context, state),
            ),
            Const.height20,
            Expanded(
              child: state.referralState!.isFetching!
                  ? CommonWidget.circularIndicator
                  : buildListViewSeparated(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReferralCode(BuildContext context, AppState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.referral_screen_referral_code,
              style: Styles.regular_arsenic_14,
            ),
            Text(
              ' ${state.referralState!.referralCode}',
              style: Styles.bold_arsenic_14,
            )
          ],
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(
                    ClipboardData(text: state.referralState!.referralCode!))
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Copied to clipboard"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 300),
              ));
            });
          },
          icon: Image.asset(
            'assets/icon/icon_copy.png',
            height: 22,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        )
      ],
    );
  }

  Widget buildListViewSeparated(BuildContext context, AppState state) {
    return RefreshIndicator(
      onRefresh: () async {
        store.dispatch(Reset.referralUserList);
        store.dispatch(referralCodeMiddleware());
        store.dispatch(referralUsersMiddleware());
      },
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: state.referralState!.referralUserList!.isNotEmpty
            ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.referralState!.referralUserList!.length + 1,
                separatorBuilder: (BuildContext context, int index) =>
                    Const.height15,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.referralState!.referralUserList!.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: state.referralState!.hasMore!
                            ? CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              )
                            : const Text('No more data'),
                      ),
                    );
                  }
                  return Container(
                    /// box decoration
                    margin: EdgeInsets.symmetric(
                        horizontal: Const.kPaddingHorizontal),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        boxShadow: [CommonWidget.box_shadow()]),
                    // child0

                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NameDataRow(
                              name: AppLocalizations.of(context)!
                                  .referral_screen_name,
                              data: state.referralState!
                                  .referralUserList![index].name),
                          Const.height5,
                          NameDataRow(
                              name: AppLocalizations.of(context)!
                                  .referral_screen_date,
                              data: state.referralState!
                                  .referralUserList![index].date),
                        ],
                      ),
                    ),
                  );
                },
              )
            : CommonWidget.noData,
      ),
    );
  }
}

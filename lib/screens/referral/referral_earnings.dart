import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RefferalEarnings extends StatefulWidget {
  const RefferalEarnings({Key? key}) : super(key: key);

  @override
  State<RefferalEarnings> createState() => _RefferalEarningsState();
}

class _RefferalEarningsState extends State<RefferalEarnings> {
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
      store.dispatch(Reset.referralEarningList);
      store.dispatch(referralEarningMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.referralEarningState!.hasMore!) {
          store.dispatch(referralEarningMiddleware());
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
                text: AppLocalizations.of(context)!.referral_earning_screen)
            .build(context),
        body: Column(
          children: [
            state.referralEarningState!.isFetching!
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
                  )
                : buildListViewSeparated(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(BuildContext context, AppState state) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal, vertical: 10),
        child: state.referralEarningState!.referralEarningList!.isNotEmpty
            ? ListView.separated(
                // shrinkWrap: true,
                itemCount:
                    state.referralEarningState!.referralEarningList!.length + 1,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 14,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index ==
                      state.referralEarningState!.referralEarningList!.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: state.referralEarningState!.hasMore!
                            ? CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              )
                            : const Text('No more data'),
                      ),
                    );
                  }
                  return Container(
                    /// box decoration
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        boxShadow: [CommonWidget.box_shadow()]),
                    // child

                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildNameDateRow(
                                name: AppLocalizations.of(context)!
                                    .referral_screen_name,
                                data: state.referralEarningState!
                                    .referralEarningList![index].name),
                            const SizedBox(
                              height: 5,
                            ),
                            buildNameDateRow(
                                name: AppLocalizations.of(context)!
                                    .referral_earning_screen_amount,
                                data: state.referralEarningState!
                                    .referralEarningList![index].amount),
                            const SizedBox(
                              height: 5,
                            ),
                            buildNameDateRow(
                                name: AppLocalizations.of(context)!
                                    .referral_screen_date,
                                data: state.referralEarningState!
                                    .referralEarningList![index].date),
                          ]),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Data Found'),
              ),
      ),
    );
  }

  Row buildNameDateRow({required var name, required var data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          name,
          style: Styles.regular_arsenic_12,
        )),
        Expanded(
            child: Text(
          data,
          style: Styles.bold_arsenic_12,
        ))
      ],
    );
  }
}

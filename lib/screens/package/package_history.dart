import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_middlewares.dart';
import 'package:active_matrimonial_flutter_app/screens/account.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageHistory extends StatefulWidget {
  bool from_package;

  PackageHistory({Key? key, this.from_package = false}) : super(key: key);

  @override
  State<PackageHistory> createState() => _PackageHistoryState();
}

class _PackageHistoryState extends State<PackageHistory> {
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
      store.dispatch(Reset.packageHistory);
      store.dispatch(packageHistoryMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.packageState!.hasMore!) {
          store.dispatch(packageHistoryMiddleware());
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
      builder: (_, state) => WillPopScope(
        onWillPop: () {
          if (widget.from_package) {
            NavigatorPush.push_remove_untill(page: Account());
            return Future<bool>.value(false);
          } else {
            return Future<bool>.value(true);
          }
        },
        child: Scaffold(
          appBar:
              CommonAppBar(text: AppLocalizations.of(context)!.package_history)
                  .build(context),
          body: SafeArea(
            child: state.packageState!.isFetching!
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.storm_grey,
                    ),
                  )
                : Container(
                    // margin: EdgeInsets.symmetric(
                    //     horizontal: Const.kPaddingHorizontal),
                    child: buildListViewSeperated(context, state),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeperated(BuildContext maincontext, AppState state) {
    return Container(
      child: state.packageState!.packageHistoryList!.isNotEmpty
          ? ListView.separated(
              controller: scrollController,
              itemCount: state.packageState!.packageHistoryList!.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == state.packageState!.packageHistoryList!.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Center(
                      child: state.packageState!.hasMore!
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
                  // child

                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 14, bottom: 14, right: 5),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_code,
                              data: state.packageState!
                                  .packageHistoryList![index].paymentCode),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_package,
                              data: state.packageState!
                                  .packageHistoryList![index].packageName),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_payment_method,
                              data: state.packageState!
                                  .packageHistoryList![index].paymentMethod),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_amount,
                              data: state.packageState!
                                  .packageHistoryList![index].amount),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_payment_status,
                              data: state.packageState!
                                  .packageHistoryList![index].paymentStatus),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)!
                                  .package_history_purchase_date,
                              data: state.packageState!
                                  .packageHistoryList![index].date),
                        ],
                      ),
                    ]),
                  ),
                );
              },
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
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
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: Styles.bold_arsenic_12,
          ),
        )
      ],
    );
  }
}

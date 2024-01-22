import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/name_date_row.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_balance_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/referral/referral_withdraw_request_middleware.dart';

class ReferralEarningsWallet extends StatefulWidget {
  const ReferralEarningsWallet({Key? key}) : super(key: key);

  @override
  State<ReferralEarningsWallet> createState() => _ReferralEarningsWalletState();
}

class _ReferralEarningsWalletState extends State<ReferralEarningsWallet> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _details = TextEditingController();

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
      store.dispatch(Reset.referralHistoryRequestList);
      store.dispatch(walletBalanceMiddleware());
      store.dispatch(referralWithdrawRequestHistoryMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.referralWithdrawRequestHistoryState!.hasMore!) {
          store.dispatch(walletBalanceMiddleware());
          store.dispatch(referralWithdrawRequestHistoryMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _amount.dispose();
    _details.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)!.referral_earnings_wallet)
            .build(context),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
                child: Row(
                  children: [
                    buildWalletBalance(state),
                    Const.width15,
                    buildWalletRecharge(),
                  ],
                ),
              ),
              Const.height20,
              Expanded(
                child: state.referralWithdrawRequestHistoryState!.isFetching!
                    ? CommonWidget.circularIndicator
                    : buildListViewSeparated(state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeparated(AppState state) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: state.referralWithdrawRequestHistoryState!
              .referralWithdrawRequestHistoryList!.isNotEmpty
          ? ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.referralWithdrawRequestHistoryState!
                      .referralWithdrawRequestHistoryList!.length +
                  1,
              separatorBuilder: (BuildContext context, int index) =>
                  Const.height15,
              itemBuilder: (BuildContext context, int index) {
                if (index ==
                    state.referralWithdrawRequestHistoryState!
                        .referralWithdrawRequestHistoryList!.length) {
                  return Center(
                    child: state.referralWithdrawRequestHistoryState!.hasMore!
                        ? CircularProgressIndicator(
                            color: MyTheme.storm_grey,
                          )
                        : const Text('No more data'),
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
                                .wallet_screen_date,
                            data: state
                                .referralWithdrawRequestHistoryState!
                                .referralWithdrawRequestHistoryList![index]
                                .date),
                        Const.height5,
                        NameDataRow(
                            name: AppLocalizations.of(context)!
                                .wallet_screen_amount,
                            data: state
                                .referralWithdrawRequestHistoryState!
                                .referralWithdrawRequestHistoryList![index]
                                .amount),
                        Const.height5,
                        NameDataRow(
                            name: AppLocalizations.of(context)!
                                .wallet_screen_details,
                            data: state
                                    .referralWithdrawRequestHistoryState!
                                    .referralWithdrawRequestHistoryList![index]
                                    .details ??
                                ''),
                        Const.height5,
                        NameDataRow(
                          name: AppLocalizations.of(context)!
                              .wallet_screen_status,
                          data: state
                              .referralWithdrawRequestHistoryState!
                              .referralWithdrawRequestHistoryList![index]
                              .status,
                          style: state
                                      .referralWithdrawRequestHistoryState!
                                      .referralWithdrawRequestHistoryList![
                                          index]
                                      .status !=
                                  'Approved'
                              ? Styles.bold_arsenic_12
                              : Styles.bold_green_12,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : CommonWidget.noData,
    );
  }

  Expanded buildWalletBalance(AppState state) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: MyTheme.app_accent_color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Column(
            children: [
              Image.asset(
                'assets/icon/icon_my_wallet.png',
                height: 16,
              ),
              Const.height10,
              Text(
                state.myWalletState!.balance!,
                style: Styles.bold_white_14,
              ),
              Const.height5,
              Text(
                AppLocalizations.of(context)!.wallet_screen_my_wallet,
                style: const TextStyle(
                    color: Color.fromRGBO(
                      225,
                      227,
                      230,
                      1,
                    ),
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildWalletRecharge() {
    return Expanded(
      child: GestureDetector(
        onTap: () => rechargeWalletDialog(),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            color: MyTheme.zircon,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/icon_plus.png',
                    height: 16,
                  ),
                  Const.height15,
                  Text(AppLocalizations.of(context)!.referral_earnings_wallet,
                      style: Styles.regular_arsenic_12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future rechargeWalletDialog() {
    return OneContext().showDialog<void>(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recharge wallet',
                style: Styles.bold_arsenic_14,
              ),
              CommonWidget.dialogCrossBtn
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Amount *',
                    style: Styles.regular_arsenic_14,
                  ),
                  Const.height10,
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        filled: true,
                        fillColor: MyTheme.solitude,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: MyTheme.app_accent_color),
                        ),

                        isDense: true,
                        hintStyle: Styles.regular_gull_grey_12,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),

                        // helperText: 'Helper text',
                      ),
                      controller: _amount,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Const.height5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Details *',
                    style: Styles.regular_arsenic_14,
                  ),
                  Const.height18,
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Enter Details",
                          filled: true,
                          fillColor: MyTheme.solitude,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: MyTheme.app_accent_color),
                          ),
                          hintStyle: Styles.regular_gull_grey_12,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        controller: _details,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyTheme.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: _submit,
              child: Text(AppLocalizations.of(context)!.common_confirm),
            ),
          ],
        );
      },
    );
  }

  void _submit() {
    if (_amount.text != '' && _details.text != '') {
      store.dispatch(
        referralWithdrawRequestMiddleware(
            amount: _amount.text, details: _details.text),
      );
    } else {
      // store.dispatch(
      //   ShowMessageAction(msg: "Form's not validated"),
      // );
    }
    OneContext().popDialog();
  }
}

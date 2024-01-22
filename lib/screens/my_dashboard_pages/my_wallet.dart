import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_balance_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_history_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/wallet_history_card.dart';

class MyWallet extends StatefulWidget {
  bool from_wallet;

  MyWallet({this.from_wallet = false, Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  ScrollController scrollController = ScrollController();

  refresh() async {
    {
      store.dispatch(Reset.myWallet);
      store.dispatch(walletHistoryMiddleware());
      store.dispatch(walletBalanceMiddleware());
    }
  }

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
      store.dispatch(Reset.myWallet);
      store.dispatch(walletHistoryMiddleware());
      store.dispatch(walletBalanceMiddleware());
    }

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.myWalletState!.hasMore!) {
          store.dispatch(walletHistoryMiddleware());
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
          if (widget.from_wallet) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const Account();
            }), (route) => false);
            return Future<bool>.value(false);
          } else {
            return Future<bool>.value(true);
          }
        },
        child: Scaffold(
          appBar:
              CommonAppBar(text: AppLocalizations.of(context)!.wallet_screen)
                  .build(context),
          body: RefreshIndicator(
            onRefresh: () => refresh(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// appbar
                    Row(
                      children: [
                        BalanceRechargeCard(
                          color: MyTheme.app_accent_color,
                          icon: 'icon_my_wallet.png',
                          name: AppLocalizations.of(context)!
                              .wallet_screen_my_wallet,
                          textStyle: Styles.regular_white_12,
                          balance: state.myWalletState!.balance!,
                          balanceStyle: Styles.bold_white_16,
                        ),
                        Const.width15,
                        BalanceRechargeCard(
                          color: MyTheme.zircon,
                          icon: 'icon_plus.png',
                          name: AppLocalizations.of(context)!
                              .wallet_screen_recharge_wallet,
                          textStyle: Styles.regular_arsenic_12,
                          onPressed: () => NavigatorPush.push(
                            context,
                            Payment(
                              payment_type: "wallet_payment",
                              title: "Wallet Recharge",
                            ),
                          ),
                        )
                      ],
                    ),
                    Const.height20,
                    state.myWalletState!.isFetching!
                        ? Expanded(
                            child: CommonWidget.circularIndicator,
                          )
                        : buildListViewSeparated(state),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeparated(AppState state) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        child: state.myWalletState!.balanceHistory!.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.myWalletState!.balanceHistory!.length + 1,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 14,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.myWalletState!.balanceHistory!.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: state.myWalletState!.hasMore!
                            ? CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              )
                            : const Text('No more data'),
                      ),
                    );
                  }
                  return WalletHistoryCard(
                    date: state.myWalletState!.balanceHistory![index].date,
                    amount: state.myWalletState!.balanceHistory![index].amount,
                    paymentMethod: state
                        .myWalletState!.balanceHistory![index].paymentMethod,
                    approval:
                        state.myWalletState!.balanceHistory![index].approval,
                  );
                },
              )
            : const Center(
                child: Text('No History Found'),
              ),
      ),
    );
  }
}

class BalanceRechargeCard extends StatelessWidget {
  final Color? color;
  final String? icon;
  final String? name;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  //balance
  final String? balance;
  final TextStyle? balanceStyle;

  BalanceRechargeCard({
    Key? key,
    this.color,
    this.icon,
    this.textStyle,
    this.name,
    this.onPressed,
    this.balance,
    this.balanceStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            // color: MyTheme.zircon,
            color: color!,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: balance == null ? 22 : 10),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/icon/$icon",
                    height: 16,
                  ),
                  if (balance != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (balance != null)
                    Text(
                      balance!,
                      style: balanceStyle,
                    ),
                  balance == null
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  Text(name!, style: textStyle!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

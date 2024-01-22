import '../../../const/my_theme.dart';
import '../../../helpers/navigator_push.dart';
import '../../../repository/wallet_repository.dart';
import '../../../screens/core.dart';
import '../../../screens/my_dashboard_pages/my_wallet.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> walletRechargeMiddleware({
  postBody,
}) {
  return (Store<AppState> store) async {
    store.state.offlinePaymentState!.isSubmit = true;

    var response =
        await WalletRepository().offlineWalletRecharge(postBody: postBody);

    if (response.result!) {
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.success));

      NavigatorPush.push_replace(page: MyWallet());
      store.dispatch(Reset.offlinePayment);
      // store.dispatch(Reset.myWallet);
      // store.dispatch(walletHistoryMiddleware());
      // store.dispatch(walletBalanceMiddleware());
    } else {
      store.dispatch(
        ShowMessageAction(msg: response.message, color: MyTheme.failure),
      );
    }
    store.state.offlinePaymentState!.isSubmit = false;
  };
}

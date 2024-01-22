import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/referral_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../enums/enums.dart';
import '../helpers/show_message_state.dart';
import '../wallet/wallet_balance_middleware.dart';

ThunkAction<AppState> referralWithdrawRequestMiddleware(
    {dynamic amount, dynamic details}) {
  return (Store<AppState> store) async {
    try {
      var data = await ReferralRepository()
          .postReferralWithdrawRequest(amount: amount, details: details);
      fetch();

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

fetch() {
  store.dispatch(Reset.referralHistoryRequestList);
  store.dispatch(referralWithdrawRequestHistoryMiddleware());
  store.dispatch(walletBalanceMiddleware());
}

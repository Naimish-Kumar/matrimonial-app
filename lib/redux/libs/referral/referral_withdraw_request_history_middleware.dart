import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_action.dart';
import 'package:active_matrimonial_flutter_app/repository/referral_repository.dart';
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> referralWithdrawRequestHistoryMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data =
          await ReferralRepository().fetchReferralWithdrawRequestHistory();
      store.dispatch(ReferralWithdrawRequestHistoryStoreAction(payload: data));
    } catch (e) {
      store.dispatch(
          ReferralWithdrawRequestHistoryFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

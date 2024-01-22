import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_action.dart';
import 'package:active_matrimonial_flutter_app/repository/referral_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> referralEarningMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.referralEarningState!.page;
    try {
      var data = await ReferralRepository().fetchReferralEarning(page: page);

      store.dispatch(ReferralEarningStoreAction(payload: data));
    } catch (e) {
      store.dispatch(ReferralEarningFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

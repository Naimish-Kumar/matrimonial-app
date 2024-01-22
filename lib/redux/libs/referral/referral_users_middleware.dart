import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_action.dart';
import 'package:active_matrimonial_flutter_app/repository/referral_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> referralUsersMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ReferralRepository().fetchReferralUsers();
      store.dispatch(ReferralUserStoreAction(payload: data));
    } catch (e) {
      store.dispatch(ReferralUserFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

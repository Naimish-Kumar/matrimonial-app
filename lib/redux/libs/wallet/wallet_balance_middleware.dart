import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_action.dart';
import 'package:active_matrimonial_flutter_app/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> walletBalanceMiddleware() {
  return (Store<AppState> store) async {
    try {
      var response = await WalletRepository().fetchWalletBalance();
      store.dispatch(MyWalletBalanceStoreAction(payload: response));
    } catch (e) {
      store.dispatch(MyWalletBalanceFailureAction(error: e.toString()));
      //debugPrint(e.toString());
      return;
    }
  };
}

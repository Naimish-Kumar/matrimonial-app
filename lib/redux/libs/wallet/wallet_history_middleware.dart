import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_action.dart';
import 'package:active_matrimonial_flutter_app/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> walletHistoryMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.myWalletState!.page;
    try {
      var response = await WalletRepository().fetchWalletHistory(page: page);
      store.dispatch(MyWalletHistoryStoreAction(payload: response));
    } catch (e) {
      store.dispatch(MyWalletHistoryFailureAction(error: e.toString()));
      //debugPrint(e.toString());
      return;
    }
  };
}

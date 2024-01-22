import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_action.dart';
import 'package:active_matrimonial_flutter_app/repository/app_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> appInfoMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await AppInfoRepository().fetchAppInfo();
      store.dispatch(AppInfoStoreAction(data: data));
    } catch (e) {
      store.dispatch(AppInfoFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

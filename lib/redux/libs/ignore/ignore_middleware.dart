import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_action.dart';
import 'package:active_matrimonial_flutter_app/repository/ignore_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> ignoreMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.ignoreState!.page;

    try {
      var data = await IgnoreRepository().fetchIgnoreList(page: page);
      store.dispatch(IgnoreStoreAction(payload: data));
    } catch (e) {
      store.dispatch(IgnoreFailureAction(error: e.toString()));
      //debugPrint(e.toString());
      return;
    }
  };
}

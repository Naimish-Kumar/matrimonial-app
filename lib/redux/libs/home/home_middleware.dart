import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_action.dart';
import 'package:active_matrimonial_flutter_app/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> homeMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await HomeRepository().fetchHome();
      store.dispatch(HomeStoreAction(payload: data));
    } catch (e) {
      store.dispatch(HomeFailureAction(error: e.toString()));
      //debugPrint(e);
      return e;
    }
  };
}

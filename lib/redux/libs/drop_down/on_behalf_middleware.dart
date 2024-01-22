import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_action.dart';
import 'package:active_matrimonial_flutter_app/repository/drop_down_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> fetchOnbehalfMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await DropDownRepository().fetchOnBehalf();

      store.dispatch(SignupStoreOnBehalfAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

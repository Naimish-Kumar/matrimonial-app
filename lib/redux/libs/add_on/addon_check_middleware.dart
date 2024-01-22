import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_action.dart';
import 'package:active_matrimonial_flutter_app/repository/app_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> addonCheckMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await AppInfoRepository().fetchAddonCheck();
      store.dispatch(AddonStoreAction(payload: data));
    } catch (e) {
      store.dispatch(AddonFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

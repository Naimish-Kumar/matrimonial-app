import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../helpers/show_message_state.dart';

ThunkAction<AppState> deactivateMiddleware({dynamic deactivate_status}) {
  return (Store<AppState> store) async {
    try {
      var data = await AuthRepository()
          .deactivate(deactivate_status: deactivate_status);

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

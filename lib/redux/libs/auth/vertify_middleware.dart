import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/verify_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/new_password.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../helpers/navigator_push.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> verifyMiddleware({code, var fromPage}) {
  return (Store<AppState> store) async {
    store.dispatch(VLoader());

    try {
      var data = await AuthRepository().verify(code: code);

      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        NavigatorPush.push_remove_untill(
            page: Main());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
    store.dispatch(VLoader());
  };
}

ThunkAction<AppState> resendVerifyCodeMiddleware() {
  return (Store<AppState> store) async {
      var data = await AuthRepository().resendVerifyCode();
      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
  };
}

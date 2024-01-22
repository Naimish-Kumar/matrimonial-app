import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../const/const.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> accountDeletionMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await AuthRepository().accountDelete();

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));

        prefs.remove(Const.accessToken);
        prefs.remove(Const.prefIsLogin);
        prefs.remove(Const.userName);
        prefs.remove(Const.userEmail);
        prefs.remove("_userImage");
        prefs.remove(Const.userId);
        prefs.remove(Const.userHeight);
        prefs.remove(Const.userAge);
        prefs.remove(Const.maritalStatus);

        NavigatorPush.push_remove_untill(page: const Main());
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

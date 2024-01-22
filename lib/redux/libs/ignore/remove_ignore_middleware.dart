import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/repository/ignore_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> removeIgnoreMiddleware({dynamic user}) {
  return (Store<AppState> store) async {
    try {
      var data = await IgnoreRepository().removeFromIgnore(user: user);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

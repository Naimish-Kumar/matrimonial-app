import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_action.dart';
import 'package:active_matrimonial_flutter_app/repository/ignore_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> addIgnoreMiddleware({from = '', required int userId}) {
  return (Store<AppState> store) async {
    try {
      var data = await IgnoreRepository().addToIgnore(userId: userId);
      if (from == 'userprofile') {
        store.dispatch(AddIgnoreAction());
      }
      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

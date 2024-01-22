import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/member_info/member_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/repository/shortlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../const/my_theme.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> addShortlistMiddleware({required int userId}) {
  return (Store<AppState> store) async {
    store.dispatch(LoadAction());
    try {
      var data = await ShortlistRepository().add_to_shortList(userId: userId);
      store.dispatch(LoadAction());

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(memberInfoMiddleware(userId: userId));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

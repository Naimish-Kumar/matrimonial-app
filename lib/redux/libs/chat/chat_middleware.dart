import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_action.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> chatMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ChatRepository().fetchChatList();
      store.dispatch(ChatStoreAction(payload: data));
      } catch (e)
      {
        store.dispatch(ChatFailureAction(error: e.toString()));
        //debugPrint(e);
        return;
      }
    };
}

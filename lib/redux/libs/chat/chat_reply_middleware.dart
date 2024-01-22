import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> chatReplyMiddleware(
    {int? id, String? text, dynamic attachment}) {
  return (Store<AppState> store) async {
    try {
      var data = await ChatRepository()
          .postChatReply(id: id, attachment: attachment, text: text);

      if (data.result == true) {
        store.dispatch(chatDetailsMiddleware(chatId: id));
        store.dispatch(chatMiddleware());
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

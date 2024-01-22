import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_action.dart';
import 'package:active_matrimonial_flutter_app/repository/chat_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> chatDetailsMiddleware({chatId}) {
  return (Store<AppState> store) async {
    // TODO  if has more page then implement for multiple page

    try {
      var data = await ChatRepository().fetchChatDetails(chatId: chatId);

      store.dispatch(ChatDetailsStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e);
      store.dispatch(ChatDetailsFailureAction(error: e.toString()));
      return;
    }
  };
}

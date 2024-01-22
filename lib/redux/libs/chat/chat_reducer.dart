import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_state.dart';

ChatState? chat_reducer(ChatState? state, action) {
  if (action == Reset.chatList) {
    state = ChatState.initialState();
    return state;
  }
  if (action is ChatStoreAction) {
    state!.isFetching = false;
    state.chatList = action.payload!.data;
    return state;
  }
  if (action is ChatFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

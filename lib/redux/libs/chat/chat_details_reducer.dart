import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_state.dart';

ChatDetailsState? chat_details_reducer(ChatDetailsState? state, dynamic action) {
  if (action is ChatDetailsStoreAction) {
    state!.isFetching = false;
    state.chatDetailsList = action.payload!.data;
    return state;
  }
  if (action is ChatDetailsFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.chatDetailsList) {
    state = ChatDetailsState.initialState();
    return state;
  }
  return state;
}

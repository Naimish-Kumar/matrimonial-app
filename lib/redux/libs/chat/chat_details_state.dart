import 'package:active_matrimonial_flutter_app/models_response/chat/chat_details_response.dart';

class ChatDetailsState {
  ChatDetailsData? chatDetailsList;
  bool? isFetching;
  String? error;

  ChatDetailsState({this.chatDetailsList, this.isFetching, this.error});

  @override
  String toString() {
    return 'ChatDetailsState{chatDetailsList: $chatDetailsList, isFetching: $isFetching, error: $error}';
  }

  ChatDetailsState.initialState()
      : chatDetailsList =null,
        isFetching = true,
        error = '';
}

import 'package:active_matrimonial_flutter_app/models_response/chat/chat_details_response.dart';

class ChatDetailsStoreAction {
  ChatDetailsResponse? payload;


  @override
  String toString() {
    return 'ChatDetailsStoreAction{payload: $payload}';
  }

  ChatDetailsStoreAction({this.payload});
}

class ChatDetailsFailureAction {
  String? error;

  ChatDetailsFailureAction({this.error});

  @override
  String toString() {
    return 'ChatDetailsFailureAction{error: $error}';
  }
}

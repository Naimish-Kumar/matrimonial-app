import 'package:active_matrimonial_flutter_app/models_response/interest/interest_request_response.dart';

class RemoveItem {
  var item;
  var context;

  RemoveItem({this.item, this.context});
}

enum AcceptRejectActions { accept, reject }

class InterestRequestStoreAction {
  InterestRequestResponse? payload;

  InterestRequestStoreAction({this.payload});

  @override
  String toString() {
    return 'InterestRequestStoreAction{payload: $payload}';
  }
}

class InterestRequestFailureAction {
  String? error;

  InterestRequestFailureAction({this.error});

  @override
  String toString() {
    return 'InterestRequestFailureAction{error: $error}';
  }
}

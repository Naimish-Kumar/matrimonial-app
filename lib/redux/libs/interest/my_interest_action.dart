import 'package:active_matrimonial_flutter_app/models_response/interest/my_interest_response.dart';

class MyInterestResetAction {
  bool? payload;

  MyInterestResetAction({this.payload});

  @override
  String toString() {
    return 'MyInterestResetAction{payload: $payload}';
  }
}

/// express interest action and others
class ExpressInterestAction {}

class InterestLoadAction {}

class MyInterestStoreAction {
  MyInterestResponse? payload;

  MyInterestStoreAction({this.payload});

  @override
  String toString() {
    return 'MyInterestStoreAction{payload: $payload}';
  }
}

class MyInterestFailureAction {
  String? error;

  MyInterestFailureAction({this.error});

  @override
  String toString() {
    return 'MyInterestFailureAction{error: $error}';
  }
}

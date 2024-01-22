import 'package:active_matrimonial_flutter_app/models_response/account_response.dart';

class AccountInfoStoreAction {
  AccountResponse? payload;

  AccountInfoStoreAction({this.payload});

  @override
  String toString() {
    return 'AccountInfoStoreAction{payload: $payload}';
  }
}

class AccountFailureAction {
  String? error;

  AccountFailureAction({this.error});

  @override
  String toString() {
    return 'AccountFailureAction{error: $error}';
  }
}

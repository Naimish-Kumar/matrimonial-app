import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_balance_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_history_res.dart';

// balance action

class MyWalletBalanceStoreAction {
  WalletBalanceResponse? payload;

  MyWalletBalanceStoreAction({this.payload});

  @override
  String toString() {
    return 'MyWalletBalanceStoreAction{payload: $payload}';
  }
}

class MyWalletBalanceFailureAction {
  String? error;

  MyWalletBalanceFailureAction({this.error});

  @override
  String toString() {
    return 'MyWalletBalanceFailureAction{error: $error}';
  }
}

// history action
class MyWalletHistoryStoreAction {
  WalletHistoryResponse? payload;

  MyWalletHistoryStoreAction({this.payload});

  @override
  String toString() {
    return 'MyWalletHistoryStoreAction{payload: $payload}';
  }
}

class MyWalletHistoryFailureAction {
  String? error;

  MyWalletHistoryFailureAction({this.error});

  @override
  String toString() {
    return 'MyWalletHistoryFailureAction{error: $error}';
  }
}

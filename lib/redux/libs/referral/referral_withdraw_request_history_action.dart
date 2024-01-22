import 'package:active_matrimonial_flutter_app/models_response/referral/referral_withdraw_request_history_response.dart';

class ReferralWithdrawRequestHistoryStoreAction {
  ReferralWithdrawRequestHistoryResponse? payload;

  ReferralWithdrawRequestHistoryStoreAction({this.payload});

  @override
  String toString() {
    return 'ReferralWithdrawRequestHistoryStoreAction{payload: $payload}';
  }
}

class ReferralWithdrawRequestHistoryFailureAction {
  String? error;

  ReferralWithdrawRequestHistoryFailureAction({this.error});

  @override
  String toString() {
    return 'ReferralWithdrawRequestHistoryFailureAction{error: $error}';
  }
}
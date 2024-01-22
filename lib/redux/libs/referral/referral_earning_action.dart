import 'package:active_matrimonial_flutter_app/models_response/referral/referral_earnings_response.dart';

class ReferralEarningStoreAction{
  ReferralEarningsResponse? payload;

  ReferralEarningStoreAction({this.payload});

  @override
  String toString() {
    return 'ReferralEarningStoreAction{payload: $payload}';
  }
}

class ReferralEarningFailureAction{
  String? error;

  ReferralEarningFailureAction({this.error});

  @override
  String toString() {
    return 'ReferralEarningFailureAction{error: $error}';
  }
}
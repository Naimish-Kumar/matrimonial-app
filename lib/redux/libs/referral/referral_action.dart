import 'package:active_matrimonial_flutter_app/models_response/referral/referral_code_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/referral/referral_users_response.dart';


// referral user actions
class ReferralUserStoreAction {
  ReferralUsersResponse? payload;

  ReferralUserStoreAction({this.payload});

  @override
  String toString() {
    return 'ReferralUserStoreAction{payload: $payload}';
  }
}

class ReferralUserFailureAction {
  String? error;

  ReferralUserFailureAction({this.error});

  @override
  String toString() {
    return 'ReferralUserFailureAction{error: $error}';
  }
}
// referral code actions
class ReferralCodeStoreAction {
  ReferralCodeResponse? payload;

  ReferralCodeStoreAction({this.payload});

  @override
  String toString() {
    return 'ReferralCodeStoreAction{payload: $payload}';
  }
}

class ReferralCodeFailureAction {
  String? error;

  ReferralCodeFailureAction({this.error});

  @override
  String toString() {
    return 'ReferralCodeFailureAction{error: $error}';
  }
}

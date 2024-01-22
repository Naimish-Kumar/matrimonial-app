import '../../../models_response/matched_profile_response.dart';

class MatchedProfileStoreAction {
  MatchedProfileResponse? payload;

  MatchedProfileStoreAction({this.payload});

  @override
  String toString() {
    return 'MatchedProfileStoreAction{data: $payload}';
  }
}

class MatchedProfileFailureAction {
  String? error;

  MatchedProfileFailureAction({this.error});

  @override
  String toString() {
    return 'MatchedProfileFailureAction{error: $error}';
  }
}

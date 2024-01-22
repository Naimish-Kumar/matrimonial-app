import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';

class MatchedProfileState {
  bool? isFetching;
  List<MemberData>? matchedProfiles = [];
  String? error;

  MatchedProfileState({
    this.isFetching,
    this.matchedProfiles,
    this.error,
  });

  MatchedProfileState.initialState()
      : isFetching = true,
        matchedProfiles = [],
        error = '';
}

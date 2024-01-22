import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_state.dart';

MatchedProfileState? matched_profile_state(
    MatchedProfileState? state, dynamic action) {
  if (action is MatchedProfileStoreAction) {
    state!.isFetching = false;
    state.matchedProfiles = action.payload!.data;
    return state;
  }
  if (action is MatchedProfileFailureAction) {
    state!.error = action.error;
    return state;
  }

  return state;
}

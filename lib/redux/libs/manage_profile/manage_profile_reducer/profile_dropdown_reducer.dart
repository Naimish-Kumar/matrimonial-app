import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/profile_dropdown_state.dart';

ProfiledropdownState profiledropdown_reducer(ProfiledropdownState state,
    dynamic action) {
  if (action is ProfiledropdownResponse) {
    state.profiledropdownResponse =
        ProfiledropdownResponse(result: action.result, data: action.data);

    return state;
  }
  return state;
}

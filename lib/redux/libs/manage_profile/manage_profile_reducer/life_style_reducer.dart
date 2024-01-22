import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/life_style_state.dart';

class IsLoading {}

class LifeStyleSaveChanges {}

LifeStyleState? life_style_reducer(LifeStyleState? state, dynamic action) {
  if (action is IsLoading) {
    state!.isLoading = !state.isLoading!;
    return state;
  }

  if (action is LifeStyleSaveChanges) {
    state!.saveChanges = !state.saveChanges!;
    return state;
  }

  if (action is LifeStyleGetResponse) {
    state!.lifeStyleGetResponse =
        LifeStyleGetResponse(data: action.data, result: action.result);
    return state;
  }

  return state;
}

import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/astronomic_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/astronomic_state.dart';

class Loader {}

class AstroSaveChanges {}

AstronomicState? astronomic_reducer(AstronomicState? state, dynamic action) {
  if (action is Loader) {
    return loader(state!, action);
  }

  if (action is AstroSaveChanges) {
    return astro_save_changes(state!, action);
  }
  if (action is AstronomicGetResponse) {
    return astro_get_response(state!, action);
  }
  return state;
}

astro_get_response(AstronomicState state, AstronomicGetResponse action) {
  state.astronomicGetResponse!.result = action.result;
  state.astronomicGetResponse!.data = action.data;
  return state;
}

astro_save_changes(AstronomicState state, AstroSaveChanges action) {
  state.pageloader = !state.pageloader!;
  return state;
}

loader(AstronomicState state, Loader action) {
  state.isloading = !state.isloading!;
  return state;
}

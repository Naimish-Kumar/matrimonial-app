import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/career_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/career_state.dart';
import 'package:active_matrimonial_flutter_app/repository/career_repository.dart';

enum CareerReset { careeer_list }

enum CareerLoader { loader, delete, update_change, save_changes }

class CareerStatusAction {
  var status;
  var id;

  CareerStatusAction({this.status, this.id});
}

CareerState? career_reducer(CareerState? state, dynamic action) {
  if (action is CareerGetResponse) {
    return career_get_response(state!, action);
  }
  if (action == CareerReset.careeer_list) {
    return reset_list(state!, action);
  }
  if (action == CareerLoader.delete) {
    return delete(state!, action);
  }
  if (action == CareerLoader.update_change) {
    return update_change(state!, action);
  }
  if (action == CareerLoader.save_changes) {
    return save_changes(state!, action);
  }
  if (action is CareerStatusAction) {
    return status_toggler(state, action);
  }

  return state;
}

status_toggler(CareerState? state, dynamic action) {
  CareerRepository().postCareerStatus(id: action.id, status: action.status);
  return state;
}

update_change(CareerState state, dynamic action) {
  state.update_changes = !state.update_changes!;
  return state;
}

save_changes(CareerState state, dynamic action) {
  state.saveChanges = !state.saveChanges!;
  return state;
}

delete(CareerState state, dynamic action) {
  state.isDelete = !state.isDelete!;
  return state;
}

reset_list(CareerState state, dynamic action) {
  state.list.clear();
  return state;
}

career_get_response(CareerState state, CareerGetResponse action) {
  state.careerGetResponse!.data = action.data;
  state.careerGetResponse!.result = action.result;
  return state;
}

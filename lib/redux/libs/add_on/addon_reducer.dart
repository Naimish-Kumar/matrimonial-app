import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_state.dart';

AddonState? addon_reducer(AddonState? state, dynamic action) {
  if (action is AddonStoreAction) {
    state!.data = action.payload!.data;
    return state;
  }
  if (action is AddonFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_details_state.dart';

PackageDetailsState? package_details_reducer(
    PackageDetailsState? state, dynamic action) {
  if (action is PackageDetailsStoreAction) {
    state!.isFetching = false;
    state.data = action.payload!.data;
    return state;
  }
  if (action is PackageDetailsFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.packageDetails) {
    state = PackageDetailsState.initialState();
    return state;
  }

  return state;
}

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/package_list_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/premium_plans/premium_plans_state.dart';

PremiumPlansState? premium_plans_reducer(
    PremiumPlansState? state, dynamic action) {
  if (action is PackageListStoreAction) {
    return package_list_response(state!, action);
  }
  if (action is PackageListFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.packageList) {
    state = PremiumPlansState.initialState();
    return state;
  }

  return state;
}

package_list_response(PremiumPlansState state, PackageListStoreAction action) {
  state.isFetching = false;
  state.premiumList = action.payload!.data;
  return state;
}

class PackageListStoreAction {
  PackageListResponse? payload;

  @override
  String toString() {
    return 'PackageListStoreAction{payload: $payload}';
  }

  PackageListStoreAction({this.payload});
}

class PackageListFailureAction {
  String? error;

  PackageListFailureAction({this.error});

  @override
  String toString() {
    return 'PackageListFailureAction{error: $error}';
  }
}

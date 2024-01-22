import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_state.dart';

PackageState? package_reducer(PackageState? state, action) {
  if (action == Reset.packageHistory) {
    state = PackageState.initialState();
    return state;
  }
  if (action is PackageHistoryStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.packageHistoryList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is PackageHistoryFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

import 'account_action.dart';
import 'account_state.dart';

AccountState? account_reducer(AccountState? state, dynamic action) {
  if (action is AccountInfoStoreAction) {
    state!.profileData = action.payload!.data;
    return state;
  }
  if (action is AccountFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

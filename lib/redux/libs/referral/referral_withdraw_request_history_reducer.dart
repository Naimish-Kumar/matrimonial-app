
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_state.dart';

ReferralWithdrawRequestHistoryState? referral_withdraw_request_history_reducer(ReferralWithdrawRequestHistoryState? state, dynamic action){
  if (action is ReferralWithdrawRequestHistoryStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.referralWithdrawRequestHistoryList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is ReferralWithdrawRequestHistoryFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.referralHistoryRequestList) {
    state = ReferralWithdrawRequestHistoryState.initialState();
    return state;
  }
  return state;
}
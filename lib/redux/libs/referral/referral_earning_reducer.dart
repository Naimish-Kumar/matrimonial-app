import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_state.dart';

ReferralEarningState? referralEarningReducer(ReferralEarningState? state, dynamic action){
  if (action is ReferralEarningStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.referralEarningList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is ReferralEarningFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.referralEarningList) {
    state = ReferralEarningState.initialState();
    return state;
  }
return state;
}
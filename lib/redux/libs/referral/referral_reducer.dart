import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_state.dart';


ReferralState? referral_reducer(ReferralState? state, dynamic action) {
  if (action is ReferralCodeStoreAction) {
    return referral_code_store(state!, action);
  }
  if(action is ReferralCodeFailureAction){
    state!.referralCode = action.error;
    return state;
  }

  // new
  if (action is ReferralUserStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.referralUserList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is ReferralUserFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.referralUserList) {
    state = ReferralState.initialState();
    return state;
  }

  return state;
}


referral_code_store(ReferralState state, ReferralCodeStoreAction action) {
  state.referralCode = action.payload!.data!.referralCode;
  return state;
}

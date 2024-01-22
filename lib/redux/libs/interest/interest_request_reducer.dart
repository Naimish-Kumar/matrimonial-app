import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/reject_interest_middleware.dart';

InterestRequestState? interest_request_reducer(
    InterestRequestState? state, dynamic action) {
  if (action is RemoveItem) {
    return remove_interest_requests_item(state!, action);
  }
  if (action == AcceptRejectActions.accept) {
    return accept(state!, action);
  }

  if (action is InterestRequestStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.interestRequestList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is MyInterestFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.interestRequestList) {
    state = InterestRequestState.initialState();
    return state;
  }

  return state;
}

accept(InterestRequestState state, dynamic action) {
  state.acceptInterest = !state.acceptInterest!;
  return state;
}

remove_interest_requests_item(InterestRequestState state, RemoveItem action) {
  state.interestRequestList!.remove(action.item);
  store.dispatch(
      rejectInterestMiddleware(ctx: action.context, userId: action.item.id));
  return state;
}

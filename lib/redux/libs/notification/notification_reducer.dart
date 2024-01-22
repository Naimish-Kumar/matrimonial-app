import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_state.dart';

import '../../../enums/enums.dart';

NotificationState? notification_reducer(
    NotificationState? state, dynamic action) {
  if (action == Reset.notification) {
    return reset(state, action);
  }
  if (action is StoreNotification) {
    store_notification(state!, action);
  }
  if (action is NotificationFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

store_notification(NotificationState state, StoreNotification action) {
  state.isFetching = false;
  if (action.payload!.meta!.lastPage != state.page) {
    state.page += 1;
  } else {
    state.hasMore = false;
  }
  state.notification_list!.addAll(action.payload!.data!);
  return state;
}

reset(NotificationState? state, dynamic action) {
  state = NotificationState.initialState();
  // state?.notification_list = [];
  // state?.page = 1;
  // state?.error = '';
  // state?.hasMore = true;

  return state;
}

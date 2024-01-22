import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_action.dart';
import 'package:active_matrimonial_flutter_app/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> notificationGetMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.notificationState!.page;

    try {
      var data = await NotificationRepository().fetchNotification(page: page);
      store.dispatch(StoreNotification(payload: data));
    } catch (e) {
      //debugPrint(e);
      // store.dispatch(NotificationFailureAction(error: e.toString()));
      store.dispatch(NotificationFailureAction(error: 'Failed To Fetch Data.'));
      return;
    }
  };
}

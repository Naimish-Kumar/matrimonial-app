import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/notification_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../enums/enums.dart';

ThunkAction<AppState> notificationReadMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await NotificationRepository().markNotifications();
      if (data.result == true) {
        store.dispatch(Reset.notification);
        store.dispatch(notificationGetMiddleware());
      }
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

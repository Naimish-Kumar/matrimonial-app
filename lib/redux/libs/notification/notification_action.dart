import 'package:active_matrimonial_flutter_app/models_response/notifications_get_response.dart';

// notification store action
class StoreNotification {
  NotificationsGetResponse? payload;

  @override
  String toString() {
    return 'StoreNotification{payload: $payload}';
  }

  StoreNotification({this.payload});
}

// notification failure action
class NotificationFailureAction {
  String? error;

  NotificationFailureAction({this.error});

  @override
  String toString() {
    return 'NotificationFailureAction{error: $error}';
  }
}

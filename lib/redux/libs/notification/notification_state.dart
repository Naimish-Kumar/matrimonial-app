import 'package:active_matrimonial_flutter_app/models_response/notifications_get_response.dart';

class NotificationState {
  int page=1;
  bool? hasMore;
  bool? isFetching;
  List<NotificationData>? notification_list;
  String? error;

  NotificationState({
    this.notification_list,
    this.isFetching,
    this.error,
  });

  NotificationState.initialState()
      : notification_list = [],
        isFetching = true,
        page = 1,
        error = '',
        hasMore = true;
}

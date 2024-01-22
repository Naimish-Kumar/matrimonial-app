import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/notifications_get_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  Future<NotificationsGetResponse> fetchNotification({page = 1}) async {
    try {
      var baseUrl = "${AppConfig.BASE_URL}/member/notifications?page=$page";
      var accessToken = prefs.getString(Const.accessToken);

      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      return notificationsGetResponseFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> markNotifications() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/mark-all-as-read";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = commonResponseFromJson(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

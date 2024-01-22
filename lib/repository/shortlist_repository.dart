import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class ShortlistRepository {
  Future<ShortlistResponse> fetchShortlist({page = 1}) async {
    try {
      var baseUrl = "${AppConfig.BASE_URL}/member/my-shortlists?page=$page";
      var accessToken = prefs.getString(Const.accessToken);

      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      return shortlistResponseFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> add_to_shortList({required int userId}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/add-to-shortlist";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"user_id": userId});
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    var data = commonResponseFromJson(response.body);

    return data;
  }

  Future<CommonResponse> removeFromShortlist({required var user}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/remove-from-shortlist";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({"user_id": user.userId});
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }
}

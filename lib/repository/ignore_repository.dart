import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/ignore/ignore_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class IgnoreRepository {
  Future<IgnoreResponse> fetchIgnoreList({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/ignored-user-list?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = ignoreResponseFromJson(response.body);

    return data;
  }

  // add to ignore

  Future<CommonResponse> addToIgnore({from = '', required int userId}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/add-to-ignore-list";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"user_id": userId});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${accessToken}",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }

  //remove from ignore

  Future<CommonResponse> removeFromIgnore({required dynamic user}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/remove-from-ignored-list";
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

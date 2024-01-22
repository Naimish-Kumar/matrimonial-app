import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../const/const.dart';
import '../models_response/search/basic_search_response/basic_search_response.dart';
import '../screens/startup_pages/splash_screen.dart';

class SearchRepository {
  Future<BasicSearchResponse> search({
    age,
    to,
    memberCode,
    maritalStatus,
    religion,
    caste,
    subCaste,
    motherTongue,
    profession,
    country,
    state,
    city,
    minHeight,
    maxHeight,
    memberType,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/member-listing";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "age_from": age,
      "age_to": to,
      "member_code": memberCode,
      "marital_status": maritalStatus,
      "religion_id": religion,
      "caste_id": caste,
      "sub_caste_id": subCaste,
      "mother_tongue": motherTongue,
      "profession": profession,
      "country_id": country,
      "state_id": state,
      "city_id": city,
      "min_height": minHeight,
      "max_height": maxHeight,
      "member_type": memberType
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: postBody);

    var data = basicSearchResponseFromJson(response.body);
    return data;
  }
}

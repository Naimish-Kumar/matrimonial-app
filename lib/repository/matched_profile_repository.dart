import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../const/const.dart';
import '../models_response/matched_profile_response.dart';
import '../screens/startup_pages/splash_screen.dart';

class MatchedProfileRepository {
  Future<MatchedProfileResponse> fetchMatchedProfiles() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/matched-profile";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = matchedProfileResponseFromJson(response.body);

    return data;
  }
}

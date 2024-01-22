import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:http/http.dart' as http;

import '../const/const.dart';
import '../models_response/happy_stories_response.dart';
import '../models_response/happy_story_and_stories/my_happy_story_check.dart';
import '../screens/startup_pages/splash_screen.dart';

class HappyStoryRepository {
  // my happy story
  Future<MyHappyStoryCheckResponse> happyStoryCheck() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/check-happy-story";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    var data = myHappyStoryCheckResponseFromJson(response.body);
    return data;
  }

  // all happy stories
  Future<HappyStoriesResponse> fetchHappyStories({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/happy-stories?page=$page";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = happyStoriesResponseFromJson(response.body);
    return data;
  }
}

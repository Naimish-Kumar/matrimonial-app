import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/blogs_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/e_happy_stories_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/new_members_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/package_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/premium_member_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/slider_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/trusted_by_millions_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

import '../models_response/Explore/banner_response.dart';
import '../models_response/Explore/review_response.dart';

class ExploreRepository {
  //slider
  Future<SliderResponse> fetchSliderImages() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/slider";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = sliderResponseFromJson(response.body);
    return data;
  }

  //premium members
  Future<PremiumMembersResponse> fetchPremiumMembers() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/premium-members";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"

    });
    var data = premiumMembersResponseFromJson(response.body);
    return data;
  }

  // banner
  Future<BannerResponse> fetchBanner() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/banner";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = bannerResponseFromJson(response.body);
    return data;
  }

  Future<TrustedByMillionsResponse> fetchTrustedBy() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/trusted-by-millions";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = trustedByMillionsResponseFromJson(response.body);
    return data;
  }

  Future<NewMembersResponse> fetchNewMembers() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/new-members";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $getToken"
    });
    var data = newMembersResponseFromJson(response.body);
    return data;
  }

  Future<EHappyStoriesResponse> fetchHappyStories() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/happy-stories";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = eHappyStoriesResponseFromJson(response.body);
    return data;
  }

  Future<PackageResponse> fetchPackages() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/packages";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = packageResponseFromJson(response.body);
    return data;
  }

  Future<ReviewResponse> fetchReviews() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/reviews";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = reviewResponseFromJson(response.body);
    return data;
  }

  Future<BlogsResponse> fetchBlogs() async {
    var baseUrl = "${AppConfig.BASE_URL}/home/blogs";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = blogsResponseFromJson(response.body);
    return data;
  }
}

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/feature_check_response.dart';
import 'package:http/http.dart' as http;

class FeatureRepository {
  // fetch feature
  Future<SystemSettingResponse> fetchFeature() async {
    var baseUrl = "${AppConfig.BASE_URL}/feature-check";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = systemSettingResponseFromJson(response.body);

    return data;
  }
}

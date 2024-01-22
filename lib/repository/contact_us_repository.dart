import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../models_response/common_response.dart';

class ContactUsRepository {
  Future<CommonResponse> sendHelp({postBody}) async {
    var baseUrl = "${AppConfig.BASE_URL}/contact-us";

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }
}

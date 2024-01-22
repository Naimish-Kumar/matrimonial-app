import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:http/http.dart' as http;

import '../models_response/blog_response.dart';

class BlogRepository {
  Future<BlogResponse> fetchBlog() async {
    var baseUrl = "${AppConfig.BASE_URL}/blogs";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = blogResponseFromJson(response.body);
    return data;
  }
}

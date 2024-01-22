import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/gallery_images_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class GalleryRepository {
  Future<GalleryImagesResponse> fetchGalleryImage() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image";
    var accessToken = prefs.getString(Const.accessToken);
    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = galleryImagesResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> deleteGalleryImage({id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image/$id";
    var accessToken = prefs.getString(Const.accessToken);
    var response = await http.delete(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> saveGalleryImage({dynamic photo}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    var pic = await http.MultipartFile.fromPath("gallery_image", photo.path);
    request.files.add(pic);

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    var data = commonResponseFromJson(responseString);
    return data;
  }
}

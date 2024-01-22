import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/package_history_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/package_list_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/packge_details_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class PackageRepository {
  // fetch package list

  Future<PackageListResponse> fetchPackageList() async {
    var baseUrl = "${AppConfig.BASE_URL}/packages";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = packageListResponseFromJson(response.body);
    return data;
  }

  // fetch package details for user
  Future<PackageDetailsResponse> fetchPackageDetail({packageId}) async {
    var baseUrl = "${AppConfig.BASE_URL}/package-details";
    var accessToken = prefs.getString(Const.accessToken);
    var post_body = jsonEncode({"package_id": packageId});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: post_body);

    var data = packageDetailsResponseFromJson(response.body);

    return data;
  }

  // fetch package history
  Future<PackageHistoryResponse> fetchPackageHistory({page}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/package-purchase-history?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = packageHistoryResponseFromJson(response.body);

    return data;
  }

  // package purchase
  Future<CommonResponse> packagePurchase(
      {amount, packageId, paymentMethod}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/package-purchase";
    var accessToken = prefs.getString(Const.accessToken);
    var post_body = jsonEncode({
      "amount": amount.toString(),
      "package_id": packageId.toString(),
      "payment_method": paymentMethod.toString()
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: post_body);

    var data = commonResponseFromJson(response.body);

    return data;
  }
}

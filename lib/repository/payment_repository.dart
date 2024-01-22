import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/payments/payment_types_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

import '../models_response/common_response.dart';

class PaymentRepository {
  var accessToken = prefs.getString(Const.accessToken);
// payment types
  Future<PaymentTypesResponse> fetchPaymentTypes() async {
    var baseUrl = "${AppConfig.BASE_URL}/payment-types";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = paymentTypesResponseFromJson(response.body);
    return data;
  }

  // paypal post method
  Future getPaypalUrlResponse({
    String? amount,
    String? payment_method,
    String? payment_type,
    var userId,
    var package_id,
  }) async {
    var post_body = jsonEncode({
      "payment_type": payment_type,
      "amount": amount,
      "payment_method": payment_method,
      "user_id": userId,
      "package_id": package_id
    });

    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/paypal/payment/pay?payment_method=$payment_method&amount=$amount&payment_type=$payment_type&user_id=$userId&package_id=                                                                                                                             $package_id");

    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: post_body);

    return jsonDecode(response.body);
  }

  // offline payment

  Future<CommonResponse> offlinePayment({
    postBody,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/package-purchase";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields["package_id"] = postBody['package_id'];
    request.fields["amount"] = postBody['amount'];
    request.fields["payment_method"] = postBody['payment_option'];
    request.fields["manual_payment_id"] = postBody['manual_payment_id'];
    request.fields["transaction_id"] = postBody['transaction_id'];
    request.fields["payment_details"] = postBody['payment_details'];

    if (postBody['payment_proof']?.path != null) {
      var pic = await http.MultipartFile.fromPath(
          "payment_proof", (postBody['payment_proof']?.path));
      request.files.add(pic);
    }

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    var res = commonResponseFromJson(responseString);
    return res;
  }
}

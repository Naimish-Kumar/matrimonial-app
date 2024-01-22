import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_balance_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_history_res.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

import '../models_response/common_response.dart';

class WalletRepository {
  Future<WalletBalanceResponse> fetchWalletBalance() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/my-wallet-balance";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = walletBalanceResponseFromJson(response.body);

    return data;
  }

  Future<WalletHistoryResponse> fetchWalletHistory({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/wallet?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = walletHistoryResponseFromJson(response.body);
    return data;
  }

  // offline wallet recharge
  Future<CommonResponse> offlineWalletRecharge({
    postBody,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/wallet-recharge";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields["amount"] = postBody['amount'];
    request.fields["payment_method"] = postBody['payment_option'];
    request.fields["manual_payment_id"] = postBody['manual_payment_id'];
    request.fields["transaction_id"] = postBody['transaction_id'];
    request.fields["payment_details"] = postBody['payment_details'];

    if (postBody['payment_proof']?.path != null) {
      var pic = await http.MultipartFile.fromPath(
          "reciept", (postBody['payment_proof']?.path));
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

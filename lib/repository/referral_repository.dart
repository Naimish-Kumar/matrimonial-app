import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/referral/referral_code_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/referral/referral_earnings_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/referral/referral_users_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/referral/referral_withdraw_request_history_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class ReferralRepository {
  Future<ReferralEarningsResponse> fetchReferralEarning({page}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/my-referral-earnings?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = referralEarningsResponseFromJson(response.body);
    return data;
  }

  Future<ReferralCodeResponse> fetchReferralCode() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/referral-code";

    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = referralCodeResponseFromJson(response.body);
    return data;
  }

  Future<ReferralUsersResponse> fetchReferralUsers() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/referred-users";

    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = referralUsersResponseFromJson(response.body);
    return data;
  }

  Future<ReferralWithdrawRequestHistoryResponse> fetchReferralWithdrawRequestHistory() async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/wallet-withdraw-request-history";

    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = referralWithdrawRequestHistoryResponseFromJson(response.body);
    return data;
  }

  
  Future<CommonResponse> postReferralWithdrawRequest({ dynamic amount, dynamic details}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/wallet-withdraw-request-store";
    var accessToken =  prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"amount": amount, "details": details});

      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          },
          body: postBody);

      var data = commonResponseFromJson(response.body);
    return data;
  }
}

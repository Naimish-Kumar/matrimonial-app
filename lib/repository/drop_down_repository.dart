import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/on_behalf.dart';
import 'package:http/http.dart' as http;

import '../const/const.dart';
import '../models_response/drop_down/caste.dart';
import '../models_response/drop_down/city.dart';
import '../models_response/drop_down/profile_dropdown_response.dart';
import '../models_response/drop_down/state.dart';
import '../models_response/drop_down/subcaste.dart';
import '../screens/core.dart';
import '../screens/startup_pages/splash_screen.dart';

class DropDownRepository {
  Future<OnbehalfResponse> fetchOnBehalf() async {
    var baseUrl = "${AppConfig.BASE_URL}/on-behalf";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = onbehalfResponseFromJson(response.body);
    return data;
  }

  Future<CasteResponse> fetchCaste(religion,
      {AppStates state = AppStates.manageProfile}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/casts/$religion";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = casteResponseFromJson(response.body);
    return data;
  }

  Future<CityResponse> fetchCity(state, AppStates appStates) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/cities/$state";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = cityResponseFromJson(response.body);
    return data;
  }

  Future<ProfiledropdownResponse> fetchProfileDropDown() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/profile-dropdown";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = profiledropdownResponseFromJson(response.body);
    return data;
  }

  Future<StateResponse> fetchState(country,
      {AppStates state = AppStates.presentAddress}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/states/$country";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = stateResponseFromJson(response.body);
    return data;
  }

  Future<SubcasteResponse> fetchSubCaste(caste, {AppStates? appStates}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/sub-casts/$caste";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = subcasteResponseFromJson(response.body);
    return data;
  }
}

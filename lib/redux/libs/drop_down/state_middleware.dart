import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../search/search_action.dart';

ThunkAction<AppState> stateMiddleware(country,
    {AppStates state = AppStates.presentAddress}) {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/states/$country";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = stateResponseFromJson(response.body);
      if (state == AppStates.partnerPreference) {
        store.dispatch(StateResponseFromPartnerPref(
          data: data.data,
        ));
      } else if (state == AppStates.permanentAddress) {
        store.dispatch(PermanentAddressStateListAction(
          data.data,
        ));
      } else if (state == AppStates.advancedSearch) {
        store.dispatch(SearchGetStateValueAction(data.data));
      } else if (state == AppStates.presentAddress) {
        store.dispatch(StateResponse(
          data: data.data,
        ));
      } else {
        store.dispatch(StateResponse(
          data: data.data,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

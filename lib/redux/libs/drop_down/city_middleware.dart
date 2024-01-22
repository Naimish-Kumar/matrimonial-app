import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/present_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/drop_down_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../search/search_action.dart';

ThunkAction<AppState> cityMiddleware(state, AppStates appStates) {
  return (Store<AppState> store) async {
    try {
      var data = await DropDownRepository().fetchCity(state, appStates);

      if (appStates == AppStates.presentAddress) {
        store.dispatch(CityResponseForPresentAddress(data.data));
      } else if (appStates == AppStates.permanentAddress) {
        store.dispatch(PermanentAddressCityListAction(data.data));
      } else if (appStates == AppStates.advancedSearch) {
        store.dispatch(SearchGetCityValueAction(
          data.data,
        ));
      } else {
        store.dispatch(CityResponse(
          data: data.data,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

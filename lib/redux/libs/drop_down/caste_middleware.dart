import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/drop_down_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> casteMiddleware(religion,
    {AppStates state = AppStates.manageProfile}) {
  return (Store<AppState> store) async {
    try {
      var data = await DropDownRepository().fetchCaste(
        religion,
      );

      if (state == AppStates.partnerPreference) {
        store.dispatch(CasteResponseForPartnerPref(data: data.data));
      } else {
        store.dispatch(CasteResponse(data: data.data));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

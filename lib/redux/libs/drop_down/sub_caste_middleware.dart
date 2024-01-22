import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/partner_expectation_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/drop_down_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> subcasteMiddleware(caste, {AppStates? appStates}) {
  return (Store<AppState> store) async {
    try {
      var data = await DropDownRepository().fetchSubCaste(caste);
      if (appStates == AppStates.partnerPreference) {
        store.dispatch(PartnerPrefSubCasteResponse(
          data: data.data,
        ));
      } else {
        store.dispatch(SubcasteResponse(
          data: data.data,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

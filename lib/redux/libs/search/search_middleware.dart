import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/search_action.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/search_repository.dart';

ThunkAction<AppState> searchMiddleware(
    {dynamic age,
    dynamic to,
    dynamic religion,
    dynamic motherTongue,
    dynamic memberCode,
    dynamic maritalStatus,
    dynamic caste,
    dynamic subCaste,
    dynamic profession,
    dynamic country,
    dynamic state,
    dynamic city,
    dynamic minHeight,
    dynamic maxHeight,
    dynamic memberType}) {
  return (Store<AppState> store) async {
    try {
      var data = await SearchRepository().search(
          age: age,
          to: to,
          religion: religion,
          motherTongue: motherTongue,
          maritalStatus: maritalStatus,
          memberCode: memberCode,
          caste: caste,
          subCaste: subCaste,
          profession: profession,
          country: country,
          state: state,
          city: city,
          minHeight: minHeight,
          maxHeight: maxHeight,
          memberType: memberType);

      store.dispatch(SearchStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e);
      store.dispatch(SearchFailureAction(error: e.toString()));
      return;
    }
  };
}

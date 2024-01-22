import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/feature_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> featureCheckMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await FeatureRepository().fetchFeature();

      if (data.result == true) {
        store.dispatch(FetchFeatureAction(payload: data));
      }
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

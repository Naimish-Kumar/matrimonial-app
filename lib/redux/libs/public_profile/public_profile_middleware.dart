import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_action.dart';
import 'package:active_matrimonial_flutter_app/repository/public_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> publicProfileMiddleware({required int userId}) {
  return (Store<AppState> store) async {
    try {
      var data =
          await PublicProfileRepository().fetchPublicProfile(userId: userId);

      store.dispatch(PublicProfileStoreAction(data: data.data));
    } catch (e) {
      debugPrint(e.toString());
      store.dispatch(PublicProfileFailureAction(error: e.toString()));
    }
  };
}

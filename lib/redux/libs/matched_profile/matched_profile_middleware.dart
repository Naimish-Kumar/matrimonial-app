import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_action.dart';
import 'package:flutter/material.dart';

import '../../../repository/matched_profile_repository.dart';
import '../../../screens/core.dart';
import '../../app/app_state.dart';

ThunkAction<AppState> matchedProfileFetchAction() {
  return (Store<AppState> store) async {
    try {
      var data = await MatchedProfileRepository().fetchMatchedProfiles();
      store.dispatch(MatchedProfileStoreAction(payload: data));
    } catch (e) {
      store.dispatch(MatchedProfileFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/my_happy_story_action.dart';
import 'package:flutter/material.dart';

import '../../../repository/happy_story_repository.dart';
import '../../../screens/core.dart';
import '../../app/app_state.dart';

ThunkAction<AppState> happyStoryCheckMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await HappyStoryRepository().happyStoryCheck();

      store.dispatch(MyHappyStoryStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e.toString());
      store.dispatch(MyHappyStoryFailureAction(error: e.toString()));
      return;
    }
  };
}

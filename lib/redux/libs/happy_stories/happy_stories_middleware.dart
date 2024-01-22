import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/happy_story_repository.dart';
import 'happy_stories_action.dart';

ThunkAction<AppState> happyStoriesMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.happyStoriesState!.page;
    try {
      var data = await HappyStoryRepository().fetchHappyStories(page: page);
      store.dispatch(HappyStoriesStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e);
      store.dispatch(HappyStoriesFailureAction(error: e.toString()));
      return;
    }
  };
}

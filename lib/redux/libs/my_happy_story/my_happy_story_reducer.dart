import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/my_happy_story_state.dart';

import 'my_happy_story_action.dart';

MyHappyStoryState? my_happy_story_reducer(
    MyHappyStoryState? state, dynamic action) {
  if (action is HappyLoader) {
    state!.happyloader = !state.happyloader!;

    return state;
  }

  if (action is MyHappyStoryStoreAction) {
    state!.myHappyStory = action.payload!.data;
    state.result = action.payload!.result;
    return state;
  }
  if (action is MyHappyStoryFailureAction) {
    state!.error = action.error;
    return state;
  }

  return state;
}

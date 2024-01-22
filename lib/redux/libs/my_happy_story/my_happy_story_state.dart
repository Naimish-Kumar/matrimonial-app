import 'package:active_matrimonial_flutter_app/models_response/happy_story_and_stories/my_happy_story_check.dart';

class MyHappyStoryState {
  bool? happyloader;
  String src = "";

  MyHappyStoryData? myHappyStory;
  String? error;
  bool? result;

  MyHappyStoryState({
    this.happyloader,
    this.myHappyStory,
    this.error,
    this.result,
  });

  MyHappyStoryState.initialState()
      : happyloader = false,
        myHappyStory = null,
        error = '';
}

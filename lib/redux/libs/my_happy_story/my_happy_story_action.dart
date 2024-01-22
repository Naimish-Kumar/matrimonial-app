import '../../../models_response/happy_story_and_stories/my_happy_story_check.dart';

class HappyLoader {}

class MyHappyStoryStoreAction {
  MyHappyStoryCheckResponse? payload;

  MyHappyStoryStoreAction({this.payload});

  @override
  String toString() {
    return 'MyHappyStoryStoreAction{payload: $payload}';
  }
}

class MyHappyStoryFailureAction {
  String? error;

  MyHappyStoryFailureAction({this.error});

  @override
  String toString() {
    return 'MyHappyStoryFailureAction{error: $error}';
  }
}

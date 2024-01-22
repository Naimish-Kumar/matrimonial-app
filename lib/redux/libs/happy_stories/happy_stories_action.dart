import '../../../models_response/happy_stories_response.dart';

class HappyStoriesStoreAction {
  HappyStoriesResponse? payload;

  HappyStoriesStoreAction({this.payload});

  @override
  String toString() {
    return 'HappyStoriesStoreAction{payload: $payload}';
  }
}

class HappyStoriesFailureAction {
  String? error;

  HappyStoriesFailureAction({this.error});

  @override
  String toString() {
    return 'HappyStoriesFailureAction{error: $error}';
  }
}

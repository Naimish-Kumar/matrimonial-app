import 'package:active_matrimonial_flutter_app/models_response/happy_stories_response.dart';

class HappyStoriesState {
  bool? isFetching;
  var page;
  bool? hasMore;
  List? happyStoriesList = [];
  String? error;

  HappyStoriesState({
    this.isFetching,
    this.error,
    this.page,
    this.hasMore,
    this.happyStoriesList,
  });

  HappyStoriesState.initialState()
      : happyStoriesList = [],
        isFetching = true,
        error = '',
        page = 1,
        hasMore = true;
}

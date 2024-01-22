import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_state.dart';

import '../../../enums/enums.dart';

HappyStoriesState? happy_stories_reducer(
    HappyStoriesState? state, dynamic action) {
  if (action == Reset.happyStories) {
    return reset(state, action);
  }

  if (action is HappyStoriesStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.happyStoriesList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is HappyStoriesFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

reset(HappyStoriesState? state, dynamic action) {
  state = HappyStoriesState.initialState();
  return state;
}

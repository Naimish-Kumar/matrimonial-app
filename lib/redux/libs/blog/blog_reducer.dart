import 'package:active_matrimonial_flutter_app/redux/libs/blog/blog_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/blog/blog_state.dart';

import '../../../enums/enums.dart';

BlogState? blog_reducer(BlogState? state, action) {
  if (action is BlogStoreAction) {
    state!.isFetching = false;
    state.blogList = action.payload!.data;
    return state;
  }
  if (action is BlogFailureAction) {
    state!.error = action.error;
    return state;
  }

  if (action == Reset.blogList) {
    state = BlogState.initialState();
    return state;
  }

  return state;
}

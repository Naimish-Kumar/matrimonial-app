import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/removeFromShortlistMiddleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_state.dart';

ShortlistState? shortlist_reducer(ShortlistState? state, dynamic action) {
  if (action is RemoveShortlistAction) {
    return deleteShortlistItem(state!, action);
  } else if (action is AddShortlistAction) {
    return addShortlistItem(state, action);
  } else if (action is DeleteShortlist) {
    return delete_from_shortlist(state!, action);
  }

  if (action is AddShortlistReset) {
    return rest_add_short_list_response(state, action);
  }

  if (action is StoreShortlist) {
    state!.isFetching = false;
    state.fullReset = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.shortlistData!.addAll(action.payload!.data!);
    return state;
  }
  if (action is ShortlistFailureAction) {
    state!.error = action.error;
    return state;
  }

  if (action is ShortListReset) {
    if (action.payload == true) {
      state!.fullReset = true;
      state.shortlistData = [];
    } else {
      state = ShortlistState.initialState();
    }
    return state;
  }

  return state;
}

rest_add_short_list_response(ShortlistState? state, dynamic action) {
  state = ShortlistState.initialState();
  return state;
}

delete_from_shortlist(ShortlistState state, DeleteShortlist action) {
  state.delete = !state.delete!;
  return state;
}

deleteShortlistItem(ShortlistState state, RemoveShortlistAction action) {
  state.shortlistData!.remove(action.data);
  store.dispatch(removeFromShortlistMiddleware(
      context: action.context, user: action.data));
  return state;
}

addShortlistItem(ShortlistState? state, AddShortlistAction action) {
  return state;
}

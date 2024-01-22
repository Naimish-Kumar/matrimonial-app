import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/shortlist_repository.dart';

ThunkAction<AppState> shortlistMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.shortlistState!.page;

    try {
      var data = await ShortlistRepository().fetchShortlist(page: page);
      store.dispatch(StoreShortlist(payload: data));
    } catch (e) {
      store.dispatch(ShortlistFailureAction(error: e.toString()));
      return;
    }
  };
}

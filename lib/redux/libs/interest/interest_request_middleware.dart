import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> interestRequestMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.interestRequestState!.page;

    try {
      var response =
          await InterestRepository().fetchInterestRequests(page: page);
      store.dispatch(InterestRequestStoreAction(payload: response));
    } catch (e) {
      store.dispatch(InterestRequestFailureAction(error: e.toString()));
      //debugPrint(e.toString());

      return;
    }
  };
}

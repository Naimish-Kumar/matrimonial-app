import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> myInterestMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.myInterestState!.page;

    try {
      var data = await InterestRepository().fetchMyInterest(page: page);
      store.dispatch(MyInterestStoreAction(payload: data));
    } catch (e) {
      store.dispatch(MyInterestFailureAction(error: e.toString()));
      //debugPrint(e.toString());

      return;
    }
  };
}

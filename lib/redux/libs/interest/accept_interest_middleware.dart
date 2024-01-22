import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../enums/enums.dart';

ThunkAction<AppState> acceptInterestMiddleware({userId}) {
  return (Store<AppState> store) async {
    store.dispatch(AcceptRejectActions.accept);

    try {
      var data =
          await InterestRepository().accept_interest_requests(userId: userId);
      store.dispatch(AcceptRejectActions.accept);

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(Reset.interestRequestList);
        store.dispatch(interestRequestMiddleware());
      } else {
        store.dispatch(
          ShowMessageAction(msg: data.message, color: MyTheme.failure),
        );
      }
    } catch (e) {
      //debugPrint(e.toString());
      return;
    }
  };
}

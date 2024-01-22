import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:flutter/material.dart';

import '../../../screens/core.dart';
import '../helpers/show_message_state.dart';
import 'interest_request_middleware.dart';

ThunkAction<AppState> rejectInterestMiddleware({ctx, userId}) {
  return (Store<AppState> store) async {
    try {
      var data =
          await InterestRepository().reject_interest_requests(userId: userId);

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
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

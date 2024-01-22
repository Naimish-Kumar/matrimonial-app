import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';

import '../helpers/show_message_state.dart';
import '../shortlist/shortlist_middleware.dart';

ThunkAction<AppState> expressInterestMiddleware({required int userId}) {
  return (Store<AppState> store) async {
    store.dispatch(ExpressInterestAction());
    try {
      var data = await InterestRepository().express_interest(userId: userId);
      store.dispatch(ExpressInterestAction());

      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(ShortListReset());
        store.dispatch(shortlistMiddleware());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e.toString());
      return;
    }
  };
}

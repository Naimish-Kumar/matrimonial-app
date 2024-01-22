import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/new_password.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../helpers/show_message_state.dart';
import 'forgetpassword_action.dart';

ThunkAction<AppState> forgetPasswordMiddleware(
    {email, send_by, bool isResend = false}) {
  return (Store<AppState> store) async {
    store.dispatch(FpLoader());

    try {
      var data =
          await AuthRepository().forgetPassword(email: email, send_by: send_by);
      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        //check is it request for resend otp or not
        if (!isResend)
          NavigatorPush.push(
              OneContext().context,
              NewPassword(
                sendBy: send_by,
                emailOrPhone: email,
              ));
      } else {
        NavigatorPush.push(
            OneContext().context,
            NewPassword(
              sendBy: send_by,
              emailOrPhone: email,
            ));

        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    store.dispatch(FpLoader());
  };
}

import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/auth_helper.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../helpers/main_helpers.dart';
import '../../../repository/app_info_repository.dart';
import '../verify/verify_action.dart';

ThunkAction<AppState> signInMiddleware(BuildContext context,
    {email, password, from}) {
  return (Store<AppState> store) async {
    store.dispatch(SignInAction(from: from));
    var data =
        (await AuthRepository().signIn(email: email, password: password))!;

    if (data.result == true) {
      AuthHelper().setAuthData(data);
      store.dispatch(
          ShowMessageAction(msg: data.message, color: MyTheme.success));
      // store.dispatch(homeMiddleware());
      store.dispatch(getUserIsApproveAction());
      // store.dispatch(getFormDataAction());

      // route redirect to main
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Main()), (route) => false);

      // clear login controllers
      store.state.signInState!.emailController!.clear();
      store.state.signInState!.passwordController!.clear();

      // firebase store fcm token fire
      final FirebaseMessaging _fcm = FirebaseMessaging.instance;

      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      String? fCMToken = await _fcm.getToken();

      if (fCMToken != null) {
        if (isLogedin) {
          // update device token
          var deviceTokenUpdateResponse = await AppInfoRepository()
              .getDeviceTokenUpdateResponse(deviceToken: fCMToken);
        }
      }

      // firebase store fcm token end
    } else {
      store.dispatch(
          ShowMessageAction(msg: data.message, color: MyTheme.failure));
    }

    store.dispatch(SignInAction(from: from));
  };
}

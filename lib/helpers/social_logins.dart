import 'package:active_matrimonial_flutter_app/redux/libs/auth/social_login_middleware.dart';
import 'package:active_matrimonial_flutter_app/social_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../main.dart';

class SocialLogins {
  onPressedGoogleLogin(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      String? accessToken = googleSignInAuthentication.accessToken;

      // print("accessToken $accessToken");
      // print("displayName ${googleUser.displayName}");
      // print("email ${googleUser.email}");
      // print("googleUser.id ${googleUser.id}");

      // var loginResponse = await AuthRepository().getSocialLoginResponse(
      //     "google", googleUser.displayName, googleUser.email, googleUser.id,
      //     access_token: accessToken);

      store.dispatch(socialLoginMiddleware(
        context: context,
          social_provider: "google",
          email: googleUser.email,
          name: googleUser.displayName,
          provider: googleUser.id,
          access_token: accessToken));
    } on Exception catch (e) {
      print("error is ....... $e");
    }
  }

  onPressedFacebookLogin(BuildContext context) async {
    final facebookLogin =
        await FacebookAuth.instance.login(loginBehavior: LoginBehavior.webOnly);

    if (facebookLogin.status == LoginStatus.success) {
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();

      // var loginResponse = await AuthRepository().getSocialLoginResponse(
      //     "facebook",

      store.dispatch(socialLoginMiddleware(
        context: context,
          social_provider: "facebook",
          email: userData['email'],
          name: userData['name'].toString(),
          provider: userData['id'].toString(),
          access_token: facebookLogin.accessToken!.token));
    } else {
      print("....Facebook auth Failed.........");
      print(facebookLogin.status);
      print(facebookLogin.message);
    }
  }

  onPressedTwitterLogin(BuildContext context) async {
    try {
      final twitterLogin = new TwitterLogin(
          apiKey: SocialConfig().twitter_consumer_key,
          apiSecretKey: SocialConfig().twitter_consumer_secret,
          redirectURI: 'activeecommerceflutterapp://');
      // Trigger the sign-in flow

      final authResult = await twitterLogin.login();

      // var loginResponse = await AuthRepository().getSocialLoginResponse(
      //     "twitter",
      //     authResult.user.name,
      //     authResult.user.email,
      //     authResult.user.id.toString(),
      //     access_token: authResult.authToken,
      //     secret_token: authResult.authTokenSecret

      store.dispatch(socialLoginMiddleware(
        context: context,
          social_provider: "twitter",
          email: authResult.user!.email,
          name: authResult.user!.name,
          provider: authResult.user!.id.toString(),
          access_token: authResult.authToken,
          secret_token: authResult.authTokenSecret));
    } on Exception catch (e) {
      print("error is ....... $e");
      // TODO
    }
  }
}

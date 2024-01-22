import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const/my_theme.dart';
import '../const/style.dart';
import '../helpers/device_info.dart';
import '../helpers/social_logins.dart';
import 'common_widget.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  bool? isGoogle = settingIsActive('google_login_activation', '1');
  bool? isFacebook = settingIsActive('facebook_login_activation', '1');
  bool? isTwitter = settingIsActive('twitter_login_activation', "1");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isGoogle! || isFacebook! || isTwitter!)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.login_screen_or_signup,
                style: Styles.regular_gull_grey_12,
              ),
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isFacebook!,
              child: CommonWidget.social_button(
                  icon: "icon_facebook.png",
                  width: 42,
                  height: 42,
                  radius: 20,
                  color: MyTheme.solitude,
                  onpressed: () {
                    SocialLogins().onPressedFacebookLogin(context);
                  }
                  // opacity: 0.1,
                  ),
            ),
            SizedBox(
              width: DeviceInfo(context).width! * 0.05,
            ),
            Visibility(
              visible: isGoogle!,
              child: CommonWidget.social_button(
                  icon: "icon_google.png",
                  width: 42,
                  height: 42,
                  radius: 20,
                  color: MyTheme.solitude,
                  // opacity: 0.1,
                  onpressed: () {
                    SocialLogins().onPressedGoogleLogin(context);
                  }),
            ),
            SizedBox(
              width: DeviceInfo(context).width! * 0.05,
            ),
            Visibility(
              visible: isTwitter!,
              child: CommonWidget.social_button(
                  icon: "icon_twitter.png",
                  width: 42,
                  height: 42,
                  radius: 20,
                  color: MyTheme.solitude,
                  // opacity: 0.1,
                  onpressed: () {
                    SocialLogins().onPressedTwitterLogin(context);
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

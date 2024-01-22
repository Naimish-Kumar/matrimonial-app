import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/vertify_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';

import '../../redux/libs/helpers/show_message_state.dart';

class SignupVerify extends StatefulWidget {
  const SignupVerify({Key? key}) : super(key: key);

  @override
  State<SignupVerify> createState() => _SignupVerifyState();
}

class _SignupVerifyState extends State<SignupVerify> {
  final _formKey = GlobalKey<FormState>();

  // controller
  final TextEditingController _verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: DeviceInfo(context).height,
          child: Stack(
            children: [
              // upper section of logo, login
              buildGradientAndLogoContainer(context),
              Positioned(
                bottom: 0,
                child: Container(
                  height: DeviceInfo(context).height! * 0.65,
                  width: DeviceInfo(context).width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      // key form
                      key: _formKey,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// password field

                          const SizedBox(
                            height: 15,
                          ),
                          buildPinPutContainer(context),

                          /// forget password
                          const SizedBox(
                            height: 40,
                          ),

                          /// this block of code works for button to
                          /// verify verification codes
                          buildVerifyButtonContainer(context, state),
                          const SizedBox(
                            height: 30,
                          ),

                          /// this block of code work for back to login
                          buildOrBackToLoginContainer(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPinPutContainer(BuildContext context) {
    return SizedBox(
      width: DeviceInfo(context).width,
      child: Pinput(
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        controller: _verifyController,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        length: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        defaultPinTheme: PinTheme(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                color: MyTheme.solitude)),
      ),
    );
  }

  Widget buildVerifyButtonContainer(BuildContext context, AppState state) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_verifyController.text.isEmpty) {
          store.dispatch(ShowMessageAction(msg: 'Please enter code.'));
        } else if (_verifyController.text.length < 6) {
          store.dispatch(ShowMessageAction(msg: 'Must be 4 character.'));
        } else {
          store.dispatch(verifyMiddleware(
              code: _verifyController.text, fromPage: "signup_verify"));
          // }
          prefs.setString("reset_verification_code", _verifyController.text);
        }
      },
      child: Container(
        height: 50,
        width: DeviceInfo(context).width,
        decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: state.verifyState!.vloader == false
              ? Text(
                  AppLocalizations.of(context)!.verify_screen_btn_text,
                  style: Styles.bold_white_14,
                )
              : CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
        ),
      ),
    );
  }

  Container buildOrBackToLoginContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.forget_screen_or_back_to,
                style: Styles.regular_gull_grey_12,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  ' ' + AppLocalizations.of(context)!.forget_screen_login,
                  style: Styles.bold_app_accent_12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container buildGradientAndLogoContainer(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height! * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        children: [
          const SizedBox(
            height: 78,
          ),
          const ImageIcon(
            AssetImage('assets/logo/app_logo.png'),
            size: 93,
            color: MyTheme.white,
          ),
          Text(
            AppLocalizations.of(context)!.verify_screen_title,
            style: const TextStyle(
                color: MyTheme.white,
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
          Text(
            AppLocalizations.of(context)!.verify_screen_sub_title,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }
}

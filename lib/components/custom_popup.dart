import 'dart:async';

import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/my_gradient_container.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/forget_password.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:one_context/one_context.dart';

import '../const/my_theme.dart';
import '../helpers/social_logins.dart';
import '../redux/libs/auth/signin_reducer.dart';
import 'common_widget.dart';

class CustomPopUp {
  BuildContext mainContext;

  CustomPopUp(
    this.mainContext,
  );

  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<dynamic> loginDialog(BuildContext context) {
    return OneContext().showDialog(
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Login",
              style: Styles.bold_arsenic_14,
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () => Navigator.pop(context, false),
                icon: Image.asset(
                  'assets/icon/icon_cross.png',
                  height: 16,
                  width: 16,
                )),
          ],
        ),
        content: StoreConnector<AppState, CustomPopUpViewModel>(
          converter: (store) => CustomPopUpViewModel.fromStore(context, store),
          builder: (_, CustomPopUpViewModel vm) => SingleChildScrollView(
            child: Form(
              // key form
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vm.valueChanger! ? "Phone" : "Email",
                    style: Styles.bold_app_accent_12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  vm.valueChanger! ? phone_field(vm) : email_field(),
                  const SizedBox(
                    height: 5,
                  ),

                  email_or_phone(context, vm),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.common_password_text,
                    style: Styles.bold_app_accent_12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  password_field(vm),
                  const SizedBox(
                    height: 5,
                  ),
                  // forget password
                  forget_password(context),
                  const SizedBox(
                    height: 20,
                  ),
                  login_button(vm, context),

                  const SizedBox(
                    height: 20,
                  ),

                  /// sign in if not have account to login
                  others(context, vm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget others(BuildContext context, CustomPopUpViewModel vm) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.login_screen_if_have_account,
              style: Styles.regular_gull_grey_12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
              child: Text(
                ' ' + AppLocalizations.of(context)!.login_screen_signup,
                style: Styles.bold_app_accent_12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (vm.isGoogle! || vm.isFacebook! || vm.isTwitter!)
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

        /// social button google facebook twiter
        buildSocialLoginContainer(
          context,
          vm,
        )
      ],
    );
  }

  Widget login_button(CustomPopUpViewModel vm, BuildContext context) {
    return InkWell(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!_formKey.currentState!.validate()) {
          // MyScaffoldMessenger().sf_messenger(text: "Form's not validated!");
        } else {
          vm.login!(
              context: mainContext,
              email: vm.valueChanger! ? vm.phoneNumber : _email.text,
              password: _password.text);

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
          // Navigator.pop(context);
        }
      },
      child: MyGradientContainer(
        text: !vm.isLogin!
            ? Text(
                AppLocalizations.of(context)!.login_button_text,
                style: Styles.bold_white_14,
              )
            : CircularProgressIndicator(
                color: MyTheme.storm_grey,
              ),
      ),
    );
  }

  Widget forget_password(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgetPassword()),
        );
      },
      child: SizedBox(
        width: DeviceInfo(context).width,
        child: Text(
          AppLocalizations.of(context)!.login_screen_forget_password,
          style: Styles.italic_app_accent_10_underline,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget password_field(CustomPopUpViewModel vm) {
    return TextFormField(
      controller: _password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        if (value.length <= 7) {
          return "Password should be 8 Characters long";
        }
        return null;
      },
      obscureText: vm.isObscure!,
      decoration: InputStyle.inputDecoratio_password(
          hint: ". . . . . . . .",
          suffixIcon: GestureDetector(
              onTap: () => store.dispatch(IsObscureAction()),
              child: Icon(
                  vm.isObscure! ? Icons.visibility_off : Icons.visibility))),
    );
  }

  Widget email_or_phone(BuildContext context, CustomPopUpViewModel vm) {
    return InkWell(
      onTap: () {
        store.dispatch(IsPhoneOrEmailChangeAction());
      },
      child: SizedBox(
        width: DeviceInfo(context).width,
        child: Text(
          vm.valueChanger!
              ? AppLocalizations.of(context)!.common_screen_use_email
              : vm.isOtpSystem!
                  ? AppLocalizations.of(context)!.common_screen_use_phone
                  : '',
          textAlign: TextAlign.right,
          style: Styles.italic_app_accent_10_underline,
        ),
      ),
    );
  }

  Widget email_field() {
    return TextFormField(
      controller: _email,
      validator: (value) {
        // Check if this field is empty
        if (value == null || value.isEmpty) {
          return 'Please enter email address';
        }

        // using regular expression
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please enter a valid email address";
        }

        // the email is valid
        return null;
      },
      decoration: InputStyle.inputDecoration_text_field(
        hint: "johndoe@example.com",
      ),
    );
  }

  Widget phone_field(CustomPopUpViewModel vm) {
    return SizedBox(
      child: vm.isOtpSystem!
          ? InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                store.dispatch(
                    SetPhoneNumberAction(payload: number.phoneNumber));
              },
              spaceBetweenSelectorAndTextField: 0,
              countries: store.state.commonState!.countriesToString(),
              // textFieldController: _email,
              selectorConfig:
                  SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG),
              // inputBorder: InputBorder.none,
              inputDecoration: InputStyle.inputDecoration_text_field(
                hint: "01XXX XXX XXX",
              ),
            )
          : SizedBox(),
    );
  }

  Widget buildSocialLoginContainer(
      BuildContext context, CustomPopUpViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: vm.isFacebook!,
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
          visible: vm.isGoogle!,
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
          visible: vm.isTwitter!,
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
    );
  }
}

class CustomPopUpViewModel {
  BuildContext context;
  bool? isGoogle;
  bool? isFacebook;
  bool? isTwitter;
  bool? valueChanger;
  bool? isOtpSystem;
  var phoneNumber;
  bool? isObscure;
  bool? isLogin;

  void Function({dynamic context, dynamic email, dynamic password})? login;

  CustomPopUpViewModel(this.context,
      {this.isGoogle,
      this.isObscure,
      this.phoneNumber,
      this.isFacebook,
      this.isTwitter,
      this.valueChanger,
      this.isOtpSystem,
      this.login,
      this.isLogin});

  static fromStore(BuildContext context, Store<AppState> store) {
    return CustomPopUpViewModel(context,
        isGoogle: store.state.systemSettingState!.settingResponse
                ?.data!['google_login_activation'] ==
            "1",
        isFacebook: store.state.systemSettingState!.settingResponse
                ?.data!['facebook_login_activation'] ==
            "1",
        isTwitter: store.state.systemSettingState!.settingResponse
                ?.data!['twitter_login_activation'] ==
            "1",
        valueChanger: store.state.signInState!.isPhone,
        isOtpSystem: store.state.addonState!.data!.otpSystem,
        phoneNumber: store.state.signInState!.phoneNumber,
        isObscure: store.state.signInState!.isObscure,
        isLogin: store.state.signInState!.isCustomLogin,
        // function
        login: ({dynamic context, dynamic email, dynamic password}) =>
            store.dispatch(signInMiddleware(context,
                email: email, password: password, from: "custom")));
  }
}

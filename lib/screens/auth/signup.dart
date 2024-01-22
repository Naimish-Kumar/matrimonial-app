import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_privacy_and_terms_page.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/social_login_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/data_time_format.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_action.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../components/contact_faq_widget.dart';
import '../../components/google_recaptcha.dart';
import '../../redux/libs/auth/signup_middleware.dart';
import '../../redux/libs/drop_down/on_behalf_middleware.dart';
import '../../redux/libs/staticPage/static_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  // visible/show or invisible/hide password
  bool _isObscure = true;
  // check box value

  bool? isGoogle = settingIsActive('google_login_activation', '1');
  bool? isFacebook = settingIsActive('facebook_login_activation', '1');
  bool? isTwitter = settingIsActive('twitter_login_activation', "1");

  bool? isOtpSystem = store.state.addonState!.data!.otpSystem ?? false;
  bool? isReferralSystem =
      store.state.addonState!.data!.referralSystem ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) => [
          store.state.signUpState!.date !=
              DateTime(store.state.signUpState!.date!.year -
                  int.parse(
                      "${store.state.systemSettingState!.settingResponse!.data!['member_min_age'] ?? 0}")),
          store.dispatch(fetchOnbehalfMiddleware()),
          store.dispatch(addonCheckMiddleware()),
          store.dispatch(fetchStaticPageAction()),
        ],
        builder: (_, state) => SizedBox(
            height: DeviceInfo(context).height,
            child: Stack(
              children: [
                buildGradeintLogo(context),
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 250,
                        ),
                        Container(
                          width: DeviceInfo(context).width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Form(
                              // key form
                              key: _formKey,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // on be half
                                  buildOnBeHalf(context, state),
                                  // first name
                                  buildFirstName(context),
                                  // last name
                                  buildLastName(context),

                                  /// gender
                                  buildGender(context, state),
                                  // data of birth
                                  buildDateOfBirth(context, state),
                                  // email or phone
                                  buildEmailPhone(context, state),
                                  // password
                                  buildPassword(context),
                                  // confirm password
                                  buildConfirmPassword(context),

                                  /// refer code

                                  isReferralSystem!
                                      ? buildRefer(context, state)
                                      : Const.heightShrink,

                                  /// recaptcha
                                  if (settingIsActive(
                                      'google_recaptcha_activation', '1'))
                                    Container(
                                      height: store.state.signUpState!
                                              .isCaptchaShowing!
                                          ? 400
                                          : 50,
                                      width: double.infinity,
                                      child: Captcha(
                                        (keyValue) {
                                          store.dispatch(SetKeyValueAction(
                                              keyValuePayload: keyValue));
                                        },
                                        handleCaptcha: (data) {
                                          if (state.signUpState!
                                                  .isCaptchaShowing!
                                                  .toString() !=
                                              data) {
                                            store.dispatch(
                                                SetIsCaptchaShowingAction(
                                                    payload: data));
                                          }
                                        },
                                        isIOS: Platform.isIOS,
                                      ),
                                    ),
                                  buildAgreeTerms(context, state),

                                  buildSignupButton(state, context),

                                  const SizedBox(
                                    height: 40,
                                  ),
                                  buildSocialLogin(context),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  ContactAndFaq(
                                    title: "Frequently Asked Questions (FAQ)",
                                    content: state.staticPageState!.faq,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // else
                //   Center(child: CircularProgressIndicator())
              ],
            )),
      ),
    );
  }

  InkWell buildSignupButton(AppState state, BuildContext context) {
    return InkWell(
      onTap: () => _signup(state),
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
        child: state.signUpState!.isLoading == false
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .signup_screen_button_text_signup,
                  style: Styles.bold_white_14,
                ),
              )
            : CommonWidget.circularIndicator,
      ),
    );
  }

  Widget buildSocialLogin(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.signup_screen_already_account,
              style: Styles.regular_gull_grey_12,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                ' ${AppLocalizations.of(context)!.signup_screen_login}',
                style: Styles.bold_app_accent_12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SocialLoginWidget()
      ],
    );
  }

  Container buildGradeintLogo(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height! * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Styles.buildLinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
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
            AppLocalizations.of(context)!.signup_screen_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context)!.signup_screen_subtitle,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }

  buildOnBeHalf(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_onbehalf,
          style: Styles.bold_app_accent_12,
        ),
        Const.height5,
        SizedBox(
          height: 49,
          child: DropdownButtonFormField<dynamic>(
            iconSize: 0.0,
            decoration: InputStyle.inputDecoration_text_field(
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            value: state.signUpState!.on_behalves_value,
            items: state.signUpState!.onBehalfList!
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e.id,
                child: Text(
                  e.name!,
                  style: Styles.regular_arsenic_14,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              store.dispatch(SignupSetOnBehalvesAction(payload: newValue));
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildFirstName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_first_name,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.signUpState?.firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter First Name';
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(
            hint: "John",
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildLastName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_last_name,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.signUpState?.lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Last Name';
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(
            hint: "Doe",
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildGender(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_gender,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 50,
          child: DropdownButtonFormField(
              validator: (dynamic val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
              decoration: InputStyle.inputDecoration_text_field(
                  suffixIcon: const Icon(Icons.keyboard_arrow_down)),
              value: state.signUpState!.currentGender,
              items: state.signUpState!.genderItems!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                    style: Styles.regular_arsenic_14,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                store.dispatch(SignupSetGenderAction(payload: newValue));
              }),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildDateOfBirth(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_dob,
          style: const TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: MyTheme.solitude,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: state.systemSettingState!.isMinimumAge!
                  ? DateTime(
                      DateTime.now().year -
                          int.parse(
                            state.systemSettingState!.settingResponse
                                ?.data!['member_min_age'],
                          ),
                      state.signUpState!.date!.month,
                      state.signUpState!.date!.day,
                    )
                  : state.signUpState!.date!,
              firstDate: DateTime(1970),
              lastDate: state.systemSettingState!.isMinimumAge!
                  ? DateTime(
                      DateTime.now().year -
                          int.parse(
                            state.systemSettingState!.settingResponse
                                ?.data!['member_min_age'],
                          ),
                      state.signUpState!.date!.month,
                      state.signUpState!.date!.day,
                    )
                  : state.signUpState!.date!,
            );

            if (newDate == null) return;
            store.dispatch(SignupSetDateTimeAction(payload: newDate));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    DateFormat('d MMMM yyyy').format(
                        DateTime.parse(state.signUpState!.date.toString())),
                    style: Styles.regular_arsenic_14,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: MyTheme.gull_grey,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildEmailPhone(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.signUpState!.emailOrPhone! ? "Phone" : "Email",
          style: const TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        state.signUpState!.emailOrPhone!
            ? SizedBox(
                child: isOtpSystem!
                    ? InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          store.dispatch(
                              SignupSetPhoneNumberAction(payload: number));
                        },
                        spaceBetweenSelectorAndTextField: 0,
                        countries: store.state.commonState!.countriesToString(),
                        selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG),
                        // inputBorder: InputBorder.none,
                        inputDecoration: InputStyle.inputDecoration_text_field(
                          hint: "01XXX XXX XXX",
                        ),
                      )
                    : Const.heightShrink,
              )
            : TextFormField(
                controller: store.state.signUpState?.emailController,
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
                  // suffixIcon: Icon(
                  //   Icons.expand_more,
                  // )
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            store.dispatch(SignupSetEmailOrPhoneAction());
          },
          child: SizedBox(
            width: DeviceInfo(context).width,
            child: Text(
              state.signUpState!.emailOrPhone!
                  ? AppLocalizations.of(context)!.common_screen_use_email
                  : isOtpSystem!
                      ? AppLocalizations.of(context)!.common_screen_use_phone
                      : "",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 10,
                color: MyTheme.app_accent_color,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  buildPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.common_password_text,
          style: const TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.signUpState?.passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            }
            if (value.length <= 7) {
              return "Password should be 8 Charecters long";
            }
            return null;
          },
          obscureText: _isObscure,
          decoration: InputStyle.inputDecoratio_password(
            hint: ". . . . . . .",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: DeviceInfo(context).width,
          child: Text(
            AppLocalizations.of(context)!.common_screen_8_or_more_char,
            style: Styles.regular_gull_grey_10,
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buildConfirmPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.common_screen_confim_password,
          style: const TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.signUpState?.confirmPasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Confirm Password';
            }
            if (store.state.signUpState?.passwordController!.text.toString() !=
                store.state.signUpState?.confirmPasswordController!.text
                    .toString()) {
              return "Password don't match";
            }
            return null;
          },
          obscureText: _isObscure,
          decoration: InputStyle.inputDecoratio_password(
            hint: ". . . . . . .",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buildRefer(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.signup_screen_refer_code,
          style: const TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.signUpState?.referController,
          decoration: InputStyle.inputDecoration_text_field(
            hint: "Type your refer code",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
      ],
    );
  }

  buildAgreeTerms(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 21,
        ),
        SizedBox(
          width: DeviceInfo(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  value: state.signUpState!.checkBox,
                  activeColor: MyTheme.app_accent_color,
                  onChanged: (bool? value) {
                    store.dispatch(SignupCheckBoxAction(payload: value));
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: DeviceInfo(context).width! / 2,
                child: RichText(
                  text: TextSpan(
                    // style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: AppLocalizations.of(context)!
                              .signup_screen_terms_part1,
                          style: Styles.regular_app_accent_12),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigatorPush.push(
                                  context,
                                  CommonPrivacyAndTerms(
                                    title: "Term Conditions Page",
                                    content: state
                                        .staticPageState!.termsAndCondition,
                                  ));
                            },
                          text: AppLocalizations.of(context)!
                              .signup_screen_terms_part2,
                          style: Styles.bold_app_accent_12),
                      TextSpan(
                          text: AppLocalizations.of(context)!
                              .signup_screen_terms_part3,
                          style: Styles.regular_app_accent_12),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigatorPush.push(
                                  context,
                                  CommonPrivacyAndTerms(
                                    title: "Privacy Policy Page",
                                    content:
                                        state.staticPageState!.privacyPolicy,
                                  ));
                            },
                          text: AppLocalizations.of(context)!
                              .signup_screen_terms_part4,
                          style: Styles.bold_app_accent_12),
                    ],
                  ),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }

  void _signup(AppState state) {
    if (state.signUpState!.checkBox == false) {
      store.dispatch(ShowMessageAction(
        msg: 'Agree to terms and condition!',
      ));
    } else if (_formKey.currentState!.validate()) {
      if (state.signUpState!.currentGender == "Male") {
        state.signUpState?.genderController!.text = "1";
      } else {
        state.signUpState?.genderController!.text = "2";
      }

      store.dispatch(
        signupMiddleware(context,
            firstName: state.signUpState?.firstNameController!.text,
            lastName: state.signUpState?.lastNameController!.text,
            emailOrPhone: state.signUpState!.emailOrPhone!
                ? state.signUpState!.phoneNumber
                : state.signUpState?.emailController!.text,
            emailOrPhoneText:
                state.signUpState!.emailOrPhone! ? "phone" : "email",
            onBehalf: state.signUpState!.on_behalves_value,
            gender: state.signUpState?.genderController!.text,
            dateOfBirth: yearMonthDay(state.signUpState!.date!),
            password: state.signUpState?.passwordController!.text,
            passwordConfirmation:
                state.signUpState?.confirmPasswordController!.text,
            referral: state.signUpState?.referController!.text,
            recapthca: state.signUpState!.googleRecaptchaKey),
      );
    }
  }
}

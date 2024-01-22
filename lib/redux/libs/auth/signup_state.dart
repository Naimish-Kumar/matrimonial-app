import 'package:flutter/material.dart';

class SignUpState {
  bool? isLoading;

  List? onBehalfList = [];
  bool? isCaptchaShowing;
  String? googleRecaptchaKey;

  SignUpState({
    this.isLoading,
    this.onBehalfList,
    this.firstNameController,
    this.lastNameController,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    this.dobController,
    this.referController,
    this.genderController,
    this.phoneNumber,
    this.date,
    this.on_behalves_value,
    this.genderItems,
    this.currentGender,
    this.checkBox,
    this.emailOrPhone,
    this.isCaptchaShowing,
    this.googleRecaptchaKey,
  });

  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? dobController = TextEditingController();
  TextEditingController? referController = TextEditingController();
  TextEditingController? genderController = TextEditingController();
  var phoneNumber;
  DateTime? date = DateTime.now();
  var on_behalves_value;

  List? genderItems = ['Male', 'Female'];
  String? currentGender = "Male";

  bool? checkBox = false;
  bool? emailOrPhone;

  copyWith({
    bool? isLoading,
    List? onBehalfList,
    String? firstNameController,
    String? lastNameController,
    String? emailController,
    String? passwordController,
    String? confirmPasswordController,
    String? dobController,
    String? referController,
    String? genderController,
    var phoneNumber,
    DateTime? date,
    var on_behalves_value,
    List? genderItems,
    String? currentGender,
    bool? checkBox,
    bool? emailOrPhone,
    bool? isCaptchaShowing,
    String? googleRecaptchaKey,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      onBehalfList: onBehalfList ?? this.onBehalfList,
      firstNameController: TextEditingController(
          text: firstNameController ?? this.firstNameController?.text),
      lastNameController: TextEditingController(
          text: lastNameController ?? this.lastNameController?.text),
      emailController: TextEditingController(
          text: emailController ?? this.emailController?.text),
      passwordController: TextEditingController(
          text: passwordController ?? this.passwordController?.text),
      confirmPasswordController: TextEditingController(
          text: confirmPasswordController ??
              this.confirmPasswordController?.text),
      dobController: TextEditingController(
          text: dobController ?? this.dobController?.text),
      referController: TextEditingController(
          text: referController ?? this.referController?.text),
      genderController: TextEditingController(
          text: genderController ?? this.genderController?.text),
      phoneNumber: TextEditingController(text: phoneNumber ?? this.phoneNumber),
      date: date ?? this.date,
      on_behalves_value: on_behalves_value ?? this.on_behalves_value,
      genderItems: genderItems ?? this.genderItems,
      currentGender: currentGender ?? this.currentGender,
      checkBox: checkBox ?? this.checkBox,
      emailOrPhone: checkBox ?? this.checkBox,
      isCaptchaShowing: isCaptchaShowing ?? this.isCaptchaShowing,
      googleRecaptchaKey: googleRecaptchaKey ?? this.googleRecaptchaKey,
    );
  }

  SignUpState.initialState()
      : checkBox = false,
        emailOrPhone = false,
        isCaptchaShowing = false,
        googleRecaptchaKey = "",
        onBehalfList = [],
        isLoading = false;
}

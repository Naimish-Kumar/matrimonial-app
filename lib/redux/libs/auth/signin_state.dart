import 'package:flutter/material.dart';

class SignInState {
  bool? isLogin;
  bool? isCustomLogin;
  bool? isPhone;
  var phoneNumber;
  bool? isObscure;

  // controllers
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  SignInState({
    this.isLogin,
    this.isPhone,
    this.isObscure,
    this.isCustomLogin,
  });

  SignInState.initialState()
      : isPhone = false,
        isObscure = true,
        isCustomLogin = false,
        emailController = TextEditingController(text: ''),
        passwordController = TextEditingController(text: ''),
        isLogin = false;
}

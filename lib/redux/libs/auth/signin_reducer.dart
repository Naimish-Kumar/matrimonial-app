import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../../../screens/core.dart';

SignInState? sign_in_reducer(SignInState? state, dynamic action) {
  if (action is SignInAction) {
    return loader(state, action);
  }
  if (action is IsPhoneOrEmailChangeAction) {
    return is_phone_or_email(state!, action);
  }
  if (action is SetPhoneNumberAction) {
    state!.phoneNumber = action.payload;
    return state;
  }
  if (action is IsObscureAction) {
    state!.isObscure = !state.isObscure!;
    return state;
  }
  if (action is LoginRequest) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.signInFormKey.currentState!.validate()) {
      store.dispatch(
        signInMiddleware(
          OneContext().context!,
          email:
              state.isPhone! ? state.phoneNumber : state.emailController!.text,
          password: state.passwordController!.text,
        ),
      );
    }
    return state;
  }

  return state;
}

class IsPhoneOrEmailChangeAction {}

class LoginRequest {}

is_phone_or_email(SignInState state, ValueChanger) {
  state.isPhone = !state.isPhone!;
  return state;
}

loader(SignInState? state, SignInAction action) {
  if (action.from == "custom") {
    state!.isCustomLogin = !state.isCustomLogin!;
  } else {
    state!.isLogin = !state.isLogin!;
  }
  return state;
}

import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_state.dart';

SignUpState? sign_up_reducer(SignUpState? state, dynamic action) {
  if (action is SignupReset) {
    return state?.copyWith(
        firstNameController: "",
        lastNameController: "",
        emailController: "",
        passwordController: "",
        phoneNumber: "",
        confirmPasswordController: "",
        checkBox: false);
  }
  if (action is SignUpAction) {
    return loader(state!, action);
  }
  if (action is SignupSetPhoneNumberAction) {
    state?.phoneNumber = action.payload!.phoneNumber;
    return state;
  }
  if (action is SignupSetDateTimeAction) {
    state?.date = action.payload!;
    return state;
  }
  if (action is SignupSetOnBehalvesAction) {
    state?.on_behalves_value = action.payload;
    return state;
  }
  if (action is SignupSetGenderAction) {
    state!.currentGender = action.payload;
    return state;
  }
  if (action is SignupCheckBoxAction) {
    state!.checkBox = !state.checkBox!;
    return state;
  }
  if (action is SignupSetEmailOrPhoneAction) {
    state!.emailOrPhone = !state.emailOrPhone!;
    return state;
  }
  if (action is SignupStoreOnBehalfAction) {
    state!.onBehalfList = action.payload!.data;
    state.on_behalves_value = state.onBehalfList!.first.id;
    return state;
  }

  if (action is SetKeyValueAction) {
    state!.googleRecaptchaKey = action.keyValuePayload;
    return state;
  }
  if (action is SetIsCaptchaShowingAction) {
    state!.isCaptchaShowing = action.payload;
    return state;
  }

  return state;
}

loader(SignUpState state, SignUpAction action) {
  state.isLoading = !state.isLoading!;
  return state;
}

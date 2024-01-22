class ResetPasswordState {
  bool? passwordObscure;
  bool? confirmPasswordObscure;
  bool? rp_loader;

  ResetPasswordState(
      {this.passwordObscure, this.confirmPasswordObscure, this.rp_loader});

  ResetPasswordState.initialState()
      : passwordObscure = true,
        rp_loader = false,
        confirmPasswordObscure = true;
}

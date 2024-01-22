class ForgetPassword {}

class SendCodeAction {}

class FpLoader {}

class ForgetPasswordEmailOrPhoneAction {}

class SetForgetPasswordPhoneNumberAction {
  String? payload;

  SetForgetPasswordPhoneNumberAction({this.payload});

  @override
  String toString() {
    return 'SetForgetPasswordPhoneNumberAction{payload: $payload}';
  }
}

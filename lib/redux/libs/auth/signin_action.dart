class SignInAction {
  String? from;

  SignInAction({this.from});

  @override
  String toString() {
    return 'SignInAction{from: $from}';
  }
}

class SetPhoneNumberAction {
  var payload;

  @override
  String toString() {
    return 'SetPhoneNumberAction{payload: $payload}';
  }

  SetPhoneNumberAction({this.payload});
}

class IsObscureAction {
  @override
  String toString() {
    return 'IsObscureAction{}';
  }
}

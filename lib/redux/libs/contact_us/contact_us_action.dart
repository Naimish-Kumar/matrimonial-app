class SetContactUsKeyValueAction {
  var keyValuePayload;

  SetContactUsKeyValueAction({this.keyValuePayload});

  @override
  String toString() {
    return 'SetContactUsKeyValueAction{keyValuePayload: $keyValuePayload}';
  }
}

class SetContactUsIsCaptchaShowingAction {
  var payload;

  SetContactUsIsCaptchaShowingAction({this.payload});
  @override
  String toString() {
    return 'SetContactUsIsCaptchaShowingAction{payload: $payload}';
  }
}

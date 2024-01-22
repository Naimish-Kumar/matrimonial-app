import 'package:flutter/material.dart';

class ForgetPasswordState {
  bool? fp_loader;

  final formKey = GlobalKey<FormState>();

  TextEditingController? forgetpasswordController = TextEditingController();
  bool? valueChanger;
  var phoneNumber;

  ForgetPasswordState({
    this.fp_loader,
    this.valueChanger,
    this.forgetpasswordController,
  });

  ForgetPasswordState.initialState()
      : fp_loader = false,
        valueChanger = false,
        forgetpasswordController = TextEditingController(text: '');
}

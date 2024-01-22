import 'package:flutter/material.dart';

class ChangePasswordState {
  bool cp_loader;
  bool oldpass;
  bool newpass;
  bool confirmpass;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordState.initialState()
      : oldpass = false,
        newpass = false,
        confirmpass = false,
        cp_loader = false;
}

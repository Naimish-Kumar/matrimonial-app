import 'package:flutter/material.dart';

class ContactUsState {
  bool isSubmit;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? subjectController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  bool? isCaptchaShowing;
  String? googleRecaptchaKey;

  ContactUsState({
    required this.isSubmit,
    this.nameController,
    this.emailController,
    this.subjectController,
    this.descriptionController,
    this.isCaptchaShowing,
    this.googleRecaptchaKey,
  });

  ContactUsState.initialState()
      : nameController = TextEditingController(text: ''),
        isSubmit = false,
        emailController = TextEditingController(text: ''),
        subjectController = TextEditingController(text: ''),
        isCaptchaShowing = false,
        googleRecaptchaKey = "",
        descriptionController = TextEditingController(text: '');
}

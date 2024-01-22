import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/introduction_get_response.dart';
import 'package:flutter/material.dart';

class IntroductionState {
  bool? isLoading;
  final formKey = GlobalKey<FormState>();
  IntroData? introData;
  TextEditingController? textController = TextEditingController();

  IntroductionState({
    this.isLoading,
    this.introData,
    this.textController,
  });

  IntroductionState.initialState()
      : introData = null,
        textController = TextEditingController(text: ''),
        isLoading = false;
}

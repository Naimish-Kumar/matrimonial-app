import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/family_get_response.dart';
import 'package:flutter/material.dart';

class FamilyState {
  bool? isloading;
  bool? pageloader;
  FamilyGetResponse? familyGetResponse;
  TextEditingController? fatherController = TextEditingController();
  TextEditingController? motherController = TextEditingController();
  TextEditingController? siblingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FamilyData? familyData;

  FamilyState({
    this.isloading,
    this.pageloader,
    this.familyGetResponse,
    this.fatherController,
    this.motherController,
    this.siblingController,
    this.familyData,
  });

  FamilyState.initialState()
      : isloading = false,
        familyData = null,
        fatherController = TextEditingController(text: ''),
        motherController = TextEditingController(text: ''),
        siblingController = TextEditingController(text: ''),
        pageloader = false;
}

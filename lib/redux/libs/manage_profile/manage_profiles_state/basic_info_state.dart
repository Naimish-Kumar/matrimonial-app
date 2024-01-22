import 'dart:io';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/basic_Info_get_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicInfoState {
  BasicInfoData? basicInfo;
  TextEditingController? f_nameController = TextEditingController();
  TextEditingController? l_nameController = TextEditingController();
  TextEditingController? no_childController = TextEditingController();

  TextEditingController? phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  //for image uploading
  ImagePicker picker = ImagePicker();
  File? image;
  String? imageName;
  //for image uploading end

  List<String> gender_items = ['Male', 'Female'];
  bool? isloading;
  DDown? marital_status_value;
  DDown? on_behalves_value;
  String? gendervalue = "Male";

  DateTime date;

  BasicInfoState({
    this.basicInfo,
    this.isloading,
    this.f_nameController,
    this.l_nameController,
    this.no_childController,
    this.phoneController,
    required this.date,
  });

  BasicInfoState.initialState()
      : isloading = false,
        f_nameController = TextEditingController(text: ''),
        l_nameController = TextEditingController(text: ''),
        no_childController = TextEditingController(text: ''),
        phoneController = TextEditingController(text: ''),
        date = DateTime.now();
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfflinePaymentState {
  TextEditingController? idController = TextEditingController();
  TextEditingController? detailController = TextEditingController();
// image
  final ImagePicker picker = ImagePicker();
  File? image;
  String? imgName;
  bool? isSubmit;

  OfflinePaymentState({
    this.idController,
    this.detailController,
    this.imgName,
    this.isSubmit,
  });

  OfflinePaymentState.initialState()
      : idController = TextEditingController(text: ''),
        imgName = null,
        isSubmit = false,
        detailController = TextEditingController(text: '');
}

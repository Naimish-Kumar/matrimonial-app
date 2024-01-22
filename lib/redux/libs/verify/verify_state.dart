import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserVerifyState {
  List<VerificationModel>? formList = [];
  bool? isFetching;
  bool? isApprove;
  bool? verificationInfo;
  ImagePicker picker = ImagePicker();
  File? image;
  String? imageName;
  UserVerifyState(
      {this.formList, this.isFetching, this.isApprove, this.verificationInfo});

  @override
  String toString() {
    return 'VerifyState{formList: $formList, isFetching: $isFetching, isApprove: $isApprove}';
  }

  UserVerifyState.initialState()
      : formList = [],
        isApprove = false,
        verificationInfo = false,
        isFetching = true;
}

// model verify
class VerificationModel<T> {
  String? key, type, title;
  T data;
  List<dynamic>? options;

  VerificationModel(
      {required this.key,
      required this.type,
      required this.title,
      required this.data,
      this.options});
}

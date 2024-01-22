import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../app_config.dart';
import '../../../models_response/verification_form/is_approved_response.dart';
import '../../../models_response/verification_form/verification_form_response.dart';
import '../../../screens/core.dart';
import '../../../screens/startup_pages/splash_screen.dart';

class VerifyFormStoreAction {
  List<VerificationFormResponse>? payload;

  VerifyFormStoreAction({this.payload});

  @override
  String toString() {
    return 'VerifyFormStoreAction{payload: $payload}';
  }
}

class SetSelectValueAction {
  String? payload;
  int? index;

  SetSelectValueAction({this.payload, this.index});

  @override
  String toString() {
    return 'SetSelectValueAction{payload: $payload, index: $index}';
  }
}

class SetMultipleSelectValueAction {
  String? payload;
  int? index;

  SetMultipleSelectValueAction({this.payload, this.index});

  @override
  String toString() {
    return 'SetMultipleSelectValueAction{payload: $payload, index: $index}';
  }
}

class SetMultipleSelectRemoveAction {
  int? payload;
  int? index;

  SetMultipleSelectRemoveAction({this.payload, this.index});

  @override
  String toString() {
    return 'SetMultipleSelectValueAction{payload: $payload, index: $index}';
  }
}

class SetFileAction {
  var payload;
  int? index;

  SetFileAction({this.payload, this.index});

  @override
  String toString() {
    return 'SetFileAction{payload: $payload, index: $index}';
  }
}

class CheckVerifyAction {
  var route;
  bool? willPop;

  CheckVerifyAction({
    this.route,
    this.willPop = true,
  });

  @override
  String toString() {
    return 'CheckVerifyAction{route: $route, willPop: $willPop}';
  }
}

class IsApprovedAction {
  IsApprovedResponse? payload;

  IsApprovedAction({this.payload});

  @override
  String toString() {
    return 'IsApprovedAction{payload: $payload}';
  }
}

class SetBVerifyFormImage {
  String? imageName;
  File? image;

  SetBVerifyFormImage({this.imageName, this.image});

  @override
  String toString() {
    return 'SetBVerifyFormImage{imageName: $imageName, image: $image}';
  }
}

ThunkAction<AppState> getFormDataAction() {
  return (Store<AppState> store) async {
    try {
      var data = await getFormData();

      store.dispatch(VerifyFormStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e.toString());
      return;
    }
  };
}

getFormData() async {
  try {
    var baseUrl = "${AppConfig.BASE_URL}/member/verification_form";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    // var responseJson;
    // print(response.contentLength);
    // if (response.contentLength! < 100) {
    //   // print(response.contentLength);
    //   prefs.setBool(Const.verifyFormSubmit, true);
    //   responseJson = json.decode(response.body);
    // } else {
    return verificationFormResponseFromJson(response.body);
  } catch (e) {
    rethrow;
  }
}

ThunkAction<AppState> getUserIsApproveAction() {
  return (Store<AppState> store) async {
    try {
      var data = await getResponse();
      store.dispatch(IsApprovedAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      // return;
    }
  };
}

getResponse() async {
  try {
    var baseUrl = "${AppConfig.BASE_URL}/member/is-approved";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    return isApprovedResponseFromJson(response.body);
  } catch (e) {
    rethrow;
  }
}

ThunkAction<AppState> getVerifyImageAction(index) {
  return (Store<AppState> store) async {
    try {
      final image = await store
          .state.manageProfileCombineState!.basicInfoState!.picker
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tmpImage = File(image.path);

      store.dispatch(
        SetFileAction(
          index: index,
          payload: tmpImage,
        ),
      );
      // store.dispatch(
      //   SetBVerifyFormImage(
      //     imageName: tmpImage.path.split('/').last,
      //     image: tmpImage,
      //   ),
      // );
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  };
}

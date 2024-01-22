import 'dart:io';

import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/basic_Info_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/basic_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models_response/drop_down/profile_dropdown_response.dart';
import '../../../../screens/core.dart';
import '../manage_profile_middleware/manage_profile_update_middlewares.dart';

BasicInfoState? basic_info_reducer(BasicInfoState? state, dynamic action) {
  if (action == SaveChanges.basicInfo) {
    state!.isloading = !state.isloading!;
    return state;
  }

  if (action is BasicInfoStoreAction) {
    bir_basic_info_get_response(state!, action);
  }
  if (action is SetBasicGalImage) {
    print('setting basic gal image');
    state!.image = action.image;
    state.imageName = action.imageName;
    return state;
  }

  if (action == UpdateInfo.basicInfo) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.formKey.currentState!.validate()) {
      store.dispatch(
        basicInfoUpdateMiddleware(
          f_name: state.f_nameController!.text,
          l_name: state.l_nameController!.text,
          gender: state.gendervalue?.toLowerCase() == "male" ? 1 : 2,
          dob: state.date.toString(),
          phone: state.phoneController!.text,
          onbehalf: state.on_behalves_value?.id,
          m_status: state.marital_status_value?.id,
          noofChild: state.no_childController!.text,
          photo: state.image,
        ),
      );
    }
    return state;
  }

  if (action is SetBasicDate) {
    state!.date = action.payload!;
    return state;
  }

  return state;
}

bir_basic_info_get_response(BasicInfoState state, BasicInfoStoreAction action) {
  // store data to store
  state.basicInfo = action.payload!.data;

  store.dispatch(authMiddleware());

  store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
      .onbehalfList!
      .forEach((element) {
    if (state.basicInfo!.onbehalf.id == element.id) {
      state.on_behalves_value = element;
    }
  });

  store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
      .maritialStatus!
      .forEach((element) {
    if (state.basicInfo!.maritialStatus == element.name) {
      state.marital_status_value = element;
    }
  });
  setBasicInfo(state);

  return state;
}

setBasicInfo(BasicInfoState state) {
  print(state.basicInfo);
  state.f_nameController!.text = state.basicInfo!.firsName!;

  state.l_nameController!.text = state.basicInfo!.lastName!;

  state.no_childController!.text = state.basicInfo!.noOfChildren!.toString();

  state.phoneController!.text = state.basicInfo!.phone!;

  state.gendervalue = state.basicInfo!.gender!;

  state.date = DateTime.parse(state.basicInfo!.dateOfBirth.toString());
}

ThunkAction<AppState> getBasicGalleryImageAction() {
  return (Store<AppState> store) async {
    try {
      final image = await store
          .state.manageProfileCombineState!.basicInfoState!.picker
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tmpImage = File(image.path);
      store.dispatch(
        SetBasicGalImage(
          imageName: tmpImage.path.split('/').last,
          image: tmpImage,
        ),
      );
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  };
}

class BasicInfoStoreAction {
  BasicInfoGetResponse? payload;

  BasicInfoStoreAction({this.payload});

  @override
  String toString() {
    return 'BasicInfoStoreAction{payload: $payload}';
  }
}

class SetBasicGalImage {
  String? imageName;
  File? image;

  SetBasicGalImage({this.imageName, this.image});

  @override
  String toString() {
    return 'SetBasicGalImage{imageName: $imageName, image: $image}';
  }
}

class BasicProfiledropdownResponse {
  ProfiledropdownResponseData? data;
  bool? result;
  BasicProfiledropdownResponse({this.data, this.result});
}

class SetBasicDate {
  DateTime? payload;

  SetBasicDate({this.payload});

  @override
  String toString() {
    return 'SetBasicDate{payload: $payload}';
  }
}

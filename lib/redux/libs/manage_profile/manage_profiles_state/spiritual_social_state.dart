import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/spiritual_social_get_response.dart';
import 'package:flutter/material.dart';

class SpiritualSocialState {
  bool? isloading;
  bool? spSaveChanges;
  final SpiritualSocialGetResponse? spiritualSocialGetResponse;
  final CasteResponse? casteResponse;
  final SubcasteResponse? subcasteResponse;
  TextEditingController ethnicityController = TextEditingController(text: "");
  TextEditingController personalController = TextEditingController(text: '');

  TextEditingController communityController = TextEditingController(text: '');

  DDown? religion_val;
  DDown? caste_val;
  DDown? sub_caste_val;
  DDown? family_val;

  set_sloader() {
    this.isloading = !isloading!;
  }

  set_sp_save_change() {
    this.spSaveChanges = !spSaveChanges!;
  }

  SpiritualSocialState(
      {this.spiritualSocialGetResponse,
      this.isloading,
      this.spSaveChanges,
      this.casteResponse,
      this.subcasteResponse});
  SpiritualSocialState.initialState()
      : isloading = false,
        spSaveChanges = false,
        spiritualSocialGetResponse = SpiritualSocialGetResponse.initialState(),
        casteResponse = CasteResponse.initialState(),
        subcasteResponse = SubcasteResponse.initialState();
}

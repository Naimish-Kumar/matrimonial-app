import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import 'package:flutter/material.dart';

class LifeStyleState {
  bool? isLoading;
  bool? saveChanges;
  LifeStyleGetResponse? lifeStyleGetResponse;
  TextEditingController living_withController = TextEditingController(text: '');
  // country
  var items = ['yes', 'no'];
  String? diet_value = 'yes';

  String? drink_value = 'yes';
  String? smoke_value = 'no';

  LifeStyleState({this.isLoading, this.saveChanges, this.lifeStyleGetResponse});

  update(
      {lifeStyleUpdateResponse, isLoading, saveChanges, lifeStyleGetResponse}) {
    return LifeStyleState(
      lifeStyleGetResponse: lifeStyleGetResponse ?? this.lifeStyleGetResponse,
      isLoading: isLoading ?? this.isLoading,
      saveChanges: saveChanges ?? this.saveChanges,
    );
  }

  LifeStyleState.initialState()
      : lifeStyleGetResponse = LifeStyleGetResponse.initialState(),
        isLoading = false,
        saveChanges = false;
}

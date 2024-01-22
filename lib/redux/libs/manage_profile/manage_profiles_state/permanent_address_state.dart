import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:flutter/material.dart';

import '../../../../models_response/drop_down/city.dart';
import '../../../../models_response/drop_down/state.dart';
import '../../../../models_response/manage_profile/get_manage_profile/permanent_address_get_response.dart';

class PermanentAddressState {
  bool? is_loading;
  bool? permanent_address_save_changes;
  final PermanentGetResponse? permanentGetResponse;

  final CityResponse? cityResponse;
  final StateResponse? stateResponse;

  TextEditingController postalCodeController = TextEditingController();
  DDown? selected_state;
  DDown? selected_city;
  DDown? selected_country;

  bool getValidation() {
    return postalCodeController.text.trim().isNotEmpty &&
        selected_country != null &&
        selected_state != null &&
        selected_city != null;
  }

  PermanentAddressState(
      {this.is_loading,
      this.cityResponse,
      this.stateResponse,
      this.permanentGetResponse,
      this.permanent_address_save_changes});

  PermanentAddressState.initialState()
      : is_loading = false,
        cityResponse = CityResponse.initialState(),
        permanentGetResponse = PermanentGetResponse.initialState(),
        stateResponse = StateResponse.initialState(),
        permanent_address_save_changes = false;
}

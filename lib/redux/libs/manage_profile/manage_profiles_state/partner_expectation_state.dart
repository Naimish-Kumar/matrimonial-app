import 'package:active_matrimonial_flutter_app/components/common_dropdown_value.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/partner_expectation_get_response.dart';
import 'package:flutter/material.dart';

class PartnerExpectationState {
  bool? isloading;
  bool? partner_expectation_save_changes;
  final CasteResponse? casteResponse;
  final SubcasteResponse? subcasteResponse;
  final StateResponse? stateResponse;
  final PartnerExpectationGetResponse? partnerExpectationGetResponse;
  List<CommonDropDownValue> commonYesNoList = [
    CommonDropDownValue("yes", "Yes"),
    CommonDropDownValue("no", "No"),
    CommonDropDownValue("dose_not_matter", "Does Not Matter")
  ];

  DDown? religion_val;
  DDown? caste_val;
  DDown? sub_caste_val;
  DDown? preferred_country;
  DDown? preferred_state;
  CommonDropDownValue? manglik_val;
  DDown? residency_country_val;
  CommonDropDownValue? children_value;
  DDown? martial_status_val;
  DDown? language_value;
  DDown? family_value;
  CommonDropDownValue? smoking_value;
  CommonDropDownValue? drinking_value;
  CommonDropDownValue? diet_value;

  TextEditingController general_requirement_controller =
      TextEditingController();
  TextEditingController min_height_controller = TextEditingController();
  TextEditingController max_weight_controller = TextEditingController();
  TextEditingController education_controller = TextEditingController();
  TextEditingController profession_controller = TextEditingController();
  TextEditingController body_controller = TextEditingController();
  TextEditingController personal_value_controller = TextEditingController();
  TextEditingController complexion_controller = TextEditingController();

  PartnerExpectationState({
    this.isloading,
    this.partner_expectation_save_changes,
    this.partnerExpectationGetResponse,
    this.casteResponse,
    this.subcasteResponse,
    this.stateResponse,
  });

  PartnerExpectationState.initialState()
      : isloading = false,
        partner_expectation_save_changes = false,
        casteResponse = CasteResponse.initialState(),
        partnerExpectationGetResponse =
            PartnerExpectationGetResponse.initialState(),
        stateResponse = StateResponse.initialState(),
        subcasteResponse = SubcasteResponse.initialState();
}

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/partner_expectation_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/state_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/sub_caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/partner_expectation_state.dart';

class Pexloader {}

class Pexsave {
  bool loaderValue;

  Pexsave(this.loaderValue);
}

class PexReligionAddValueAction {
  var value;

  PexReligionAddValueAction({this.value});
}

class PexCasteAddValueAction {
  var value;

  PexCasteAddValueAction({this.value});
}

class PexSubCasteAddValueAction {
  var value;
  PexSubCasteAddValueAction({this.value});
}

class PexPreferredCountryAddValueAction {
  var value;

  PexPreferredCountryAddValueAction({this.value});
}

class PexPreferredStateAddValueAction {
  var value;

  PexPreferredStateAddValueAction({this.value});
}

class PexManglikAddValueAction {
  var value;

  PexManglikAddValueAction({this.value});
}

class PexResidencyCountryAddValueAction {
  var value;
  PexResidencyCountryAddValueAction({this.value});
}

class PexMaritalStatusAddValueAction {
  var value;

  PexMaritalStatusAddValueAction({this.value});
}

class PexEmptyCaste {}

class PexEmptySubCaste {}

class PexEmptyPreferredState {}

class PartnerPrefInitValue {}

class PartnerPrefSubCasteResponse {
  List<DDown>? data;

  PartnerPrefSubCasteResponse({this.data});
}

PartnerExpectationState? partner_expectation_reducer(
    PartnerExpectationState? state, dynamic action) {
  if (action is Pexloader) {
    return pex_loader_toggler(state!, action);
  }
  if (action is Pexsave) {
    return pex_save_toggler(state!, action.loaderValue);
  }
  if (action is CasteResponseForPartnerPref) {
    return pex_caste_response(state!, action);
  }
  if (action is PartnerPrefSubCasteResponse) {
    return pex_sub_caste_response(state!, action);
  }
  if (action is StateResponseFromPartnerPref) {
    return pex_state_response(state!, action);
  }

  if (action is PartnerExpectationGetResponse) {
    return pex_partnerexpectation_get_response(state!, action);
  }

  if (action is PexReligionAddValueAction) {
    return pex_add_religion(state!, action);
  }

  if (action is PexCasteAddValueAction) {
    return pex_add_caste(state!, action);
  }
  if (action is PexSubCasteAddValueAction) {
    pex_add_sub_caste(state!, action);
  }

  if (action is PexEmptyCaste) {
    return pex_caste_list_clear(state!, action);
  }
  if (action is PexEmptySubCaste) {
    return pex_sub_caste_list_clear(state!, action);
  }
  if (action is PexPreferredCountryAddValueAction) {
    return pex_add_preferred_country(state!, action);
  }
  if (action is PexPreferredStateAddValueAction) {
    pex_add_preferred_state(state!, action);
  }
  if (action is PexEmptyPreferredState) {
    pex_state_state_list_clear(state!, action);
  }

  if (action is PexManglikAddValueAction) {
    return pex_add_manglik(state!, action);
  }
  if (action is PexResidencyCountryAddValueAction) {
    return pex_add_residency_country(state!, action);
  }
  if (action is PexMaritalStatusAddValueAction) {
    return pex_marital_status_value_add(state!, action);
  }
  return state;
}

pex_marital_status_value_add(
    PartnerExpectationState state, PexMaritalStatusAddValueAction action) {
  state.martial_status_val = action.value;
  return state;
}

pex_add_residency_country(
    PartnerExpectationState state, PexResidencyCountryAddValueAction action) {
  state.residency_country_val = action.value;
  return state;
}

pex_add_manglik(
    PartnerExpectationState state, PexManglikAddValueAction action) {
  state.manglik_val = action.value;
  return state;
}

pex_state_state_list_clear(
    PartnerExpectationState state, PexEmptyPreferredState action) {
  state.stateResponse!.data!.clear();
  state.preferred_state = null;
  return state;
}

pex_add_preferred_state(
    PartnerExpectationState state, PexPreferredStateAddValueAction action) {
  state.preferred_state = action.value;

  return state;
}

pex_add_preferred_country(
    PartnerExpectationState state, PexPreferredCountryAddValueAction action) {
  state.preferred_country = action.value;
  return state;
}

pex_sub_caste_list_clear(
    PartnerExpectationState state, PexEmptySubCaste action) {
  state.subcasteResponse!.data!.clear();
  state.sub_caste_val = null;
  return state;
}

pex_caste_list_clear(PartnerExpectationState state, PexEmptyCaste action) {
  state.casteResponse!.data!.clear();
  state.caste_val = null;
  return state;
}

pex_add_religion(
    PartnerExpectationState state, PexReligionAddValueAction action) {
  state.religion_val = action.value;
  return state;
}

pex_add_caste(PartnerExpectationState state, PexCasteAddValueAction action) {
  state.caste_val = action.value;
  return state;
}

pex_add_sub_caste(
    PartnerExpectationState state, PexSubCasteAddValueAction action) {
  state.sub_caste_val = action.value;
  return state;
}

pex_partnerexpectation_get_response(
    PartnerExpectationState state, PartnerExpectationGetResponse action) {
  // print(state.partnerExpectationGetResponse?.data?.toJson());
  state.partnerExpectationGetResponse!.data = action.data;
  state.general_requirement_controller.text =
      state.partnerExpectationGetResponse!.data!.general!;
  state.min_height_controller.text =
      "${state.partnerExpectationGetResponse!.data!.height ?? ''}";
  state.max_weight_controller.text =
      "${state.partnerExpectationGetResponse!.data!.weight ?? ''}";
  state.education_controller.text =
      "${state.partnerExpectationGetResponse!.data!.education ?? ''}";
  state.profession_controller.text =
      "${state.partnerExpectationGetResponse!.data!.profession ?? ''}";
  state.personal_value_controller.text =
      "${state.partnerExpectationGetResponse!.data!.personalValue ?? ''}";
  state.complexion_controller.text =
      "${state.partnerExpectationGetResponse!.data!.complexion ?? ''}";
  state.body_controller.text =
      "${state.partnerExpectationGetResponse!.data!.bodyType ?? ''}";
  pexprofile_drop_down_response(state);
  //store.dispatch(profiledropdownMiddleware());

  // state.preferred_country= DDown(id: 0,name: "Bangladesh");

  return state;
}

pex_state_response(
    PartnerExpectationState state, StateResponseFromPartnerPref action) {
  state.stateResponse!.data!.addAll(action.data!);

  state.preferred_state = state.stateResponse!.data!.first;
  if (state.partnerExpectationGetResponse!.data?.preferredStateId != null) {
    state.stateResponse!.data!.forEach((element) {
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.preferredStateId) {
        state.preferred_state = element;
      }
    });
  }

  return state;
}

pex_sub_caste_response(
    PartnerExpectationState state, PartnerPrefSubCasteResponse action) {
  // print("PartnerPrefSubCasteResponse");
  state.subcasteResponse!.data!.clear();
  state.sub_caste_val = null;

  state.subcasteResponse!.data!.addAll(action.data!);
  if (state.subcasteResponse!.data != null) {
    state.sub_caste_val = state.subcasteResponse!.data!.first;
    if (state.partnerExpectationGetResponse!.data?.subCasteId != null) {
      state.subcasteResponse!.data!.forEach((element) {
        if (element.name ==
            state.partnerExpectationGetResponse!.data!.subCasteId) {
          state.sub_caste_val = element;
        }
      });
    }
  }
  return state;
}

pex_caste_response(
    PartnerExpectationState state, CasteResponseForPartnerPref action) {
  state.casteResponse!.data!.clear();

  state.casteResponse!.data!.addAll(action.data!);

  if (state.casteResponse!.data != null &&
      state.casteResponse!.data!.isNotEmpty) {
    state.caste_val = state.casteResponse!.data!.first;
    if (state.partnerExpectationGetResponse!.data?.casteId != null) {
      state.casteResponse!.data!.forEach((element) {
        if (element.name ==
            state.partnerExpectationGetResponse!.data!.casteId) {
          state.caste_val = element;
        }
      });
    }
    store.dispatch(subcasteMiddleware(state.caste_val!.id,
        appStates: AppStates.partnerPreference));
  }
  return state;
}

pex_save_toggler(PartnerExpectationState state, bool value) {
  state.partner_expectation_save_changes =
      !state.partner_expectation_save_changes!;
  return state;
}

pex_loader_toggler(PartnerExpectationState state, Pexloader action) {
  state.isloading = !state.isloading!;
  return state;
}

pexprofile_drop_down_response(PartnerExpectationState state) {
  if (state.partnerExpectationGetResponse!.data?.residenceCountryId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .countryList!
        .forEach((element) {
      // print(element.name == store.state.manageProfileCombineState.partnerExpectationState.partnerExpectationGetResponse.data.preferredCountryId);
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.residenceCountryId) {
        state.residency_country_val = element;
      }
    });
  }

  if (state.partnerExpectationGetResponse!.data?.maritalStatusId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .maritialStatus!
        .forEach((element) {
      print(element.name ==
          state.partnerExpectationGetResponse!.data!.maritalStatusId);
      // print(element.name == store.state.manageProfileCombineState.partnerExpectationState.partnerExpectationGetResponse.data.preferredCountryId);
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.maritalStatusId) {
        state.martial_status_val = element;
      }
    });
  }

  state.children_value = state.commonYesNoList.first;

  if (state.partnerExpectationGetResponse!.data?.childrenAcceptable != null) {
    state.commonYesNoList.forEach((element) {
      // print(element.name == store.state.manageProfileCombineState.partnerExpectationState.partnerExpectationGetResponse.data.preferredCountryId);
      if (element.key ==
          state.partnerExpectationGetResponse!.data!.childrenAcceptable) {
        state.children_value = element;
      }
    });
  }

  if (state.partnerExpectationGetResponse!.data?.religionId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .religionList!
        .forEach((element) {
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.religionId) {
        state.religion_val = element;
        store.dispatch(
            casteMiddleware(element.id, state: AppStates.partnerPreference));
      }
    });
  }

  if (state.partnerExpectationGetResponse!.data?.languageId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .languageList!
        .forEach((element) {
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.languageId) {
        state.language_value = element;
      }
    });
  }

  state.smoking_value = state.commonYesNoList.first;
  if (state.partnerExpectationGetResponse!.data?.smokingAcceptable != null) {
    state.commonYesNoList.forEach((element) {
      // print(element.name == store.state.manageProfileCombineState.partnerExpectationState.partnerExpectationGetResponse.data.preferredCountryId);
      if (element.key ==
          state.partnerExpectationGetResponse!.data!.smokingAcceptable) {
        state.smoking_value = element;
      }
    });
  }

  state.drinking_value = state.commonYesNoList.first;
  if (state.partnerExpectationGetResponse!.data?.drinkingAcceptable != null) {
    state.commonYesNoList.forEach((element) {
      if (element.key ==
          state.partnerExpectationGetResponse!.data!.drinkingAcceptable) {
        state.drinking_value = element;
      }
    });
  }
  state.diet_value = state.commonYesNoList.first;
  if (state.partnerExpectationGetResponse!.data?.diet != null) {
    state.commonYesNoList.forEach((element) {
      if (element.key == state.partnerExpectationGetResponse!.data!.diet) {
        state.diet_value = element;
      }
    });
  }
  state.manglik_val = state.commonYesNoList.first;
  if (state.partnerExpectationGetResponse!.data?.manglik != null) {
    state.commonYesNoList.forEach((element) {
      if (element.key == state.partnerExpectationGetResponse!.data!.manglik) {
        state.manglik_val = element;
      }
    });
  }

  if (state.partnerExpectationGetResponse!.data?.preferredCountryId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .countryList!
        .forEach((element) {
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.preferredCountryId) {
        state.preferred_country = element;
        store.dispatch(
            stateMiddleware(element.id, state: AppStates.partnerPreference));
      }
    });
  }

  if (state.partnerExpectationGetResponse!.data?.familyValueId != null) {
    store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
        .familyValueList!
        .forEach((element) {
      if (element.name ==
          state.partnerExpectationGetResponse!.data!.familyValueId) {
        state.family_value = element;
      }
    });
  }

  return state;
}

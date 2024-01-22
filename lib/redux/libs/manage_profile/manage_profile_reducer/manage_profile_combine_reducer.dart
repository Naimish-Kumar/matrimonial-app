import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/astronomic_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/attitude_behavior_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/basic_info_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/career_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/contact_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/family_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/hobbies_interest_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/introduction_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/language_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/life_style_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/partner_expectation_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/physical_attr_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/present_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/residency_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/spiritual_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/manage_profile_combine_state.dart';

ManageProfileCombineState manage_profile_combine_reducer(
    ManageProfileCombineState? state, dynamic action) {
  if (action is UpdateTab) {
    return state!.update(selectedTabIndex: action.index);
  }

  if (action is ManageProfileCommonDropdownValuesSetAction) {
    // print("update in ManageProfileCommonDropdownValuesSetAction");
    // if(state.profiledropdownResponseData == null) {
    return state!.update(
      profiledropdownResponseData: action.data,
    );
    //}
    //return state;
  }

  return ManageProfileCombineState(
      introductionState: introduction_reducer(state!.introductionState, action),
      physicalAttrState: physical_attr_reducer(state.physicalAttrState, action),
      educationState: education_reducer(state.educationState, action),
      careerState: career_reducer(state.careerState, action),
      attributeBehaviorState:
          attitude_behavior_reducer(state.attributeBehaviorState, action),
      languageState: language_reducer(state.languageState, action),
      contactState: contact_reducer(state.contactState, action),
      lifeStyleState: life_style_reducer(state.lifeStyleState, action),
      presentAddressState:
          present_address_reducer(state.presentAddressState, action),
      permanentAddressState:
          permanent_address_reducer(state.permanentAddressState, action),
      residencyState: residency_reducer(state.residencyState, action),
      spiritualSocialState:
          spiritual_reducer(state.spiritualSocialState, action),
      partnerExpectationState:
          partner_expectation_reducer(state.partnerExpectationState, action),
      familyState: family_reducer(state.familyState, action),
      astronomicState: astronomic_reducer(state.astronomicState, action),
      basicInfoState: basic_info_reducer(state.basicInfoState, action),
      //profiledropdownState: profiledropdown_reducer(state.profiledropdownState, action),
      hobbiesInterestState:
          hobbies_interest_reducer(state.hobbiesInterestState, action),
      selectedTabIndex: state.selectedTabIndex,
      profiledropdownResponseData: state.profiledropdownResponseData);
}

class UpdateTab {
  int index;
  UpdateTab(this.index);
}

class ManageProfileCommonDropdownValuesSetAction {
  ProfiledropdownResponse data;

  ManageProfileCommonDropdownValuesSetAction(this.data);
}

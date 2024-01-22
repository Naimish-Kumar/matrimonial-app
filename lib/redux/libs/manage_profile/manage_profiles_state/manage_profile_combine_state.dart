import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/astronomic_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/attitude_behavior_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/basic_info_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/career_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/contact_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/education_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/family_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/hobbies_interest_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/introduction_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/language_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/life_style_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/partner_expectation_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/permanent_address_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/physical_attr_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/present_addres_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/profile_dropdown_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/residency_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/spiritual_social_state.dart';

class ManageProfileCombineState {
  final BasicInfoState? basicInfoState;
  final IntroductionState? introductionState;
  final PresentAddressState? presentAddressState;
  final ContactState? contactState;
  final EducationState? educationState;
  final CareerState? careerState;
  final PhysicalAttrState? physicalAttrState;
  final LanguageState? languageState;
  final HobbiesInterestState? hobbiesInterestState;
  final AttitudeBehaviorState? attributeBehaviorState;
  final ResidencyState? residencyState;
  final SpiritualSocialState? spiritualSocialState;
  final LifeStyleState? lifeStyleState;
  final AstronomicState? astronomicState;
  final PermanentAddressState? permanentAddressState;
  final FamilyState? familyState;
  final PartnerExpectationState? partnerExpectationState;

  ProfiledropdownResponse? profiledropdownResponseData;
  int? selectedTabIndex =0;


  /// profile drop down state drop down
  /// extras
  //final ProfiledropdownState profiledropdownState;


  ManageProfileCombineState({
    this.careerState,
    this.familyState,
    this.languageState,
    this.residencyState,
    this.contactState,
    this.educationState,
    this.basicInfoState,
    this.lifeStyleState,
    this.astronomicState,
    this.introductionState,
    this.physicalAttrState,
    this.presentAddressState,
    this.hobbiesInterestState,
    //this.profiledropdownState,
    this.spiritualSocialState,
    this.permanentAddressState,
    this.attributeBehaviorState,
    this.partnerExpectationState,
    this.selectedTabIndex,
    this.profiledropdownResponseData
  });

ManageProfileCombineState update({careerState,familyState,languageState,residencyState,contactState,educationState,basicInfoState,lifeStyleState,
   astronomicState,
   introductionState,
   physicalAttrState,
   presentAddressState,
   hobbiesInterestState,
   profiledropdownState,
   spiritualSocialState,
   permanentAddressState,
   attributeBehaviorState,
   partnerExpectationState,
   selectedTabIndex,profiledropdownResponseData}){
  return ManageProfileCombineState(
      careerState:careerState??this.careerState,
      familyState:familyState??this.familyState,
      languageState:languageState??this.languageState,
      residencyState:residencyState??this.residencyState,
      contactState:contactState??this.contactState,
      educationState:educationState??this.educationState,
      basicInfoState:basicInfoState??this.basicInfoState,
      lifeStyleState:lifeStyleState??this.lifeStyleState,
      astronomicState:astronomicState??this.astronomicState,
      introductionState:introductionState??this.introductionState,
      physicalAttrState:physicalAttrState??this.physicalAttrState,
      presentAddressState:presentAddressState??this.presentAddressState,
      hobbiesInterestState:hobbiesInterestState??this.hobbiesInterestState,
     // profiledropdownState:profiledropdownState??this.profiledropdownState,
      spiritualSocialState:spiritualSocialState??this.spiritualSocialState,
      permanentAddressState:permanentAddressState??this.permanentAddressState,
      attributeBehaviorState:attributeBehaviorState??this.attributeBehaviorState,
      partnerExpectationState:partnerExpectationState??this.partnerExpectationState,
      selectedTabIndex:selectedTabIndex??this.selectedTabIndex,
      profiledropdownResponseData:profiledropdownResponseData??this.profiledropdownResponseData
  );


  }

  ManageProfileCombineState.initialState()
      : introductionState = IntroductionState.initialState(),
        careerState = CareerState.initialState(),
        educationState = EducationState.initialState(),
        contactState = ContactState.initialState(),
        lifeStyleState = LifeStyleState.initialState(),
        familyState = FamilyState.initialState(),
        partnerExpectationState = PartnerExpectationState.initialState(),
        spiritualSocialState = SpiritualSocialState.initialState(),
        permanentAddressState = PermanentAddressState.initialState(),
        residencyState = ResidencyState.initialState(),
        languageState = LanguageState.initialState(),
        presentAddressState = PresentAddressState.initialState(),
      //  profiledropdownState = ProfiledropdownState.initialState(),
        astronomicState = AstronomicState.initialState(),
        basicInfoState = BasicInfoState.initialState(),
        hobbiesInterestState = HobbiesInterestState.initialState(),
        attributeBehaviorState = AttitudeBehaviorState.initialState(),
        profiledropdownResponseData= ProfiledropdownResponse(result: false,data: ProfiledropdownResponseData.init()),
        physicalAttrState = PhysicalAttrState.initialState();
}

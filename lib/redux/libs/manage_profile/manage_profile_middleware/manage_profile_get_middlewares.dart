import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/astronomic_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/attitude_behavior_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/family_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/physical_attr_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/manage_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../../components/basic_form_widget.dart';
import '../../../../models_response/manage_profile/get_manage_profile/career_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/education_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/language_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/partner_expectation_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/permanent_address_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/residency_get_response.dart';
import '../../../../models_response/manage_profile/get_manage_profile/spiritual_social_get_response.dart';
import '../manage_profile_reducer/basic_info_reducer.dart';
import '../manage_profile_reducer/career_reducer.dart';
import '../manage_profile_reducer/contact_reducer.dart';
import '../manage_profile_reducer/education_reducer.dart';
import '../manage_profile_reducer/hobbies_interest_reducer.dart';
import '../manage_profile_reducer/introduction_reducer.dart';
import '../manage_profile_reducer/present_address_reducer.dart';

ThunkAction<AppState> astronomicGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchAstronomicInfo();

      store.dispatch(AstronomicGetResponse(
        data: data.data,
        result: data.result,
      ));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> attitudeInterestsGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchAttitude();

      store.dispatch(AttitudeBehaviorStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> basicInfoGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchBasicInfo();
      store.dispatch(BasicInfoStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> careerGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchCareer();
      store.dispatch(CareerReset.careeer_list);

      data.data!.forEach((element) {
        store.state.manageProfileCombineState!.careerState!.list.add(
          CareerViewModel(
            designation_text: 'Designation',
            id: element.id,
            present: element.present,
            company_text: 'Company',
            start: '2016',
            end: '2023',
            designation_controller:
                TextEditingController(text: element.designation),
            company_controller: TextEditingController(text: element.company),
            start_controller:
                TextEditingController(text: element.start.toString()),
            end_controller: TextEditingController(text: element.end.toString()),
          ),
        );
      });

      store.dispatch(CareerGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> contactGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchContact();
      store.dispatch(ContactStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> educationGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchEducation();
      store.dispatch(EducationReset.list);

      data.data!.forEach((element) {
        store.state.manageProfileCombineState!.educationState!.list.add(
          EducationViewModel(
            id: element.id,
            degree_hint: 'Bachelor of Arts',
            institute_hint: 'Middlebury College',
            start_hint: '2016',
            end_hint: '2023',
            present: element.present,
            degree_controller: TextEditingController(text: element.degree),
            institute_controller:
                TextEditingController(text: element.institution),
            start_controller:
                TextEditingController(text: element.start.toString()),
            end_controller: TextEditingController(text: element.end.toString()),
          ),
        );
      });
      store
          .dispatch(EducationGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> familyGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchFamily();

      store.dispatch(FamilyStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> hobbiesInterestGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchHobbiesInterest();

      store.dispatch(HobbiesInterestStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> introductionGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchIntroduction();
      store.dispatch(IntroductionStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> languageGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchLanguage();
      // store.dispatch(LanguageSaveChanges());
      store.dispatch(LanguageGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> lifeStyleGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchLifeStyle();
      store
          .dispatch(LifeStyleGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> partnerExpectationGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().getPartnerExpectation();

      store.dispatch(PartnerExpectationGetResponse(
        data: data.data,
      ));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> permanentAddressGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchPermanentAddress();

      store
          .dispatch(PermanentGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> physicalAttributesGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchPhysicalAttribute();

      store.dispatch(PhysicalAttrStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> presentAddressGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchPresentAddress();
      store.dispatch(PresentAddressStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> residencyGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchResidency();

      store
          .dispatch(ResidencyGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

ThunkAction<AppState> spiritualSocialGetMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await ManageProfileRepository().fetchSpiritualBackground();

      store.dispatch(
          SpiritualSocialGetResponse(data: data.data, result: data.result));
    } catch (e) {
      debugPrint(e.toString());

      return;
    }
  };
}

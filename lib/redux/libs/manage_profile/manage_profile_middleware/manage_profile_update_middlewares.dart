import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/repository/manage_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../manage_profile_reducer/astronomic_reducer.dart';
import '../manage_profile_reducer/attitude_behavior_reducer.dart';
import '../manage_profile_reducer/career_reducer.dart';
import '../manage_profile_reducer/education_reducer.dart';
import '../manage_profile_reducer/hobbies_interest_reducer.dart';
import '../manage_profile_reducer/language_reducer.dart';
import '../manage_profile_reducer/life_style_reducer.dart';
import '../manage_profile_reducer/partner_expectation_reducer.dart';
import '../manage_profile_reducer/permanent_address_reducer.dart';
import '../manage_profile_reducer/physical_attr_reducer.dart';
import '../manage_profile_reducer/present_address_reducer.dart';
import '../manage_profile_reducer/residency_reducer.dart';
import '../manage_profile_reducer/spiritual_reducer.dart';
import 'manage_profile_get_middlewares.dart';

ThunkAction<AppState> basicInfoUpdateMiddleware(
    {context,
    dynamic f_name,
    dynamic l_name,
    dynamic gender,
    dynamic dob,
    dynamic phone,
    dynamic onbehalf,
    dynamic m_status,
    dynamic noofChild,
    dynamic photo}) {
  return (Store<AppState> store) async {
    store.dispatch(SaveChanges.basicInfo);

    var response = await ManageProfileRepository().basicInfoUpdate(
      f_name: f_name,
      l_name: l_name,
      gender: gender,
      dob: dob,
      phone: phone,
      onbehalf: onbehalf,
      m_status: m_status,
      noofChild: noofChild,
      photo: photo,
    );
    // print(response.toJson());

    if (response.result!) {
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.success));
      store.dispatch(basicInfoGetMiddleware());
      store.dispatch(accountMiddleware());
    } else {
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.failure));
    }

    store.dispatch(SaveChanges.basicInfo);
  };
}

ThunkAction<AppState> contactMiddleware({
  dynamic email,
}) {
  return (Store<AppState> store) async {
    store.dispatch(SaveChanges.contact);

    try {
      var data = await ManageProfileRepository().contactUpdate(email: email);

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(SaveChanges.contact);
  };
}

ThunkAction<AppState> introUpdateMiddleware({dynamic text}) {
  return (Store<AppState> store) async {
    store.dispatch(SaveChanges.introduction);

    try {
      var data = await ManageProfileRepository().introductionUpdate(text: text);

      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(introductionGetMiddleware());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e);
      return;
    }
    store.dispatch(SaveChanges.introduction);
  };
}

ThunkAction<AppState> presentAddressUpdateMiddleware(
    {dynamic country, dynamic state, dynamic city, dynamic postal_code}) {
  return (Store<AppState> store) async {
    store.dispatch(PresentAddressSaveChanges());

    try {
      var data = await ManageProfileRepository().updatePresentAddress(
        country: country,
        state: state,
        city: city,
        postal_code: postal_code,
      );
      store.dispatch(presentAddressGetMiddleware());
      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(PresentAddressSaveChanges());
  };
}

ThunkAction<AppState> residencyUpdateMiddleware({
  dynamic birth_country,
  dynamic residency_country,
  dynamic growup_country,
  dynamic immigration_status,
}) {
  return (Store<AppState> store) async {
    store.dispatch(ResidencySaveChanges());

    try {
      var data = await ManageProfileRepository().updateResidency(
          birth_country: birth_country,
          residency_country: residency_country,
          growup_country: growup_country,
          immigration_status: immigration_status);

      store.dispatch(residencyGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(ResidencySaveChanges());
  };
}

ThunkAction<AppState> spiritualSocialUpdateMiddleware({
  dynamic religion,
  dynamic caste,
  dynamic sub_caste,
  dynamic ethnicity,
  dynamic personal_value,
  dynamic family_value,
  dynamic community_value,
}) {
  return (Store<AppState> store) async {
    store.dispatch(SpiritualSaveChanges());

    try {
      var data = await ManageProfileRepository().updateSpiritual(
          religion: religion,
          caste: caste,
          sub_caste: sub_caste,
          ethnicity: ethnicity,
          personal_value: personal_value,
          family_value: family_value,
          community_value: community_value);

      store.dispatch(spiritualSocialGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(SpiritualSaveChanges());
  };
}

ThunkAction<AppState> astronomicUpdateMiddleware(
    {dynamic sunsign, dynamic moonsign, dynamic time, dynamic city}) {
  return (Store<AppState> store) async {
    store.dispatch(AstroSaveChanges());

    try {
      var data = await ManageProfileRepository().astronomicUpdate(
          sunsign: sunsign, moonsign: moonsign, time: (time), city: city);
      store.dispatch(astronomicGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message.toString(),
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
    store.dispatch(AstroSaveChanges());
  };
}

ThunkAction<AppState> attitudeBehaviorUpdateMiddleware({
  dynamic affection,
  dynamic humor,
  dynamic religious_service,
  dynamic political_views,
}) {
  return (Store<AppState> store) async {
    store.dispatch(AttitudeBehaviorLoader());

    try {
      var data = await ManageProfileRepository().attitudeUpdate(
        affection: affection,
        humor: humor,
        religious_service: religious_service,
        political_views: political_views,
      );
      store.dispatch(attitudeInterestsGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
    store.dispatch(AttitudeBehaviorLoader());
  };
}

/// create career

ThunkAction<AppState> careerUpdateMiddleware(
    {dynamic designation,
    dynamic company,
    dynamic start,
    dynamic end,
    dynamic id}) {
  return (Store<AppState> store) async {
    store.dispatch(CareerLoader.update_change);

    try {
      var data = await ManageProfileRepository().careerUpdate(
          designation: designation,
          company: company,
          start: start,
          end: end,
          id: id);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error in update ${e.toString()}");
      return;
    }
    store.dispatch((CareerLoader.update_change));
  };
}

ThunkAction<AppState> eudcationUpdateMiddleware(
    {dynamic degree,
    dynamic institution,
    dynamic start,
    dynamic end,
    dynamic id}) {
  return (Store<AppState> store) async {
    store.dispatch(EducationLoader.update);

    try {
      var data = await ManageProfileRepository().educationUpdate(
          degree: degree,
          institution: institution,
          start: start,
          end: end,
          id: id);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      store.dispatch(EducationLoader.update);

      print("error ${e.toString()}");
      return;
    }
    store.dispatch(EducationLoader.update);
  };
}

ThunkAction<AppState> familyUpdateMiddleware(
    {dynamic father, dynamic mother, dynamic sibling}) {
  return (Store<AppState> store) async {
    store.dispatch(SaveChanges.familyInfo);

    try {
      var data = await ManageProfileRepository()
          .updateFamily(father: father, mother: mother, sibling: sibling);
      store.dispatch(familyGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
    store.dispatch(SaveChanges.familyInfo);
  };
}

ThunkAction<AppState> hobbiesInterestUpdateMiddleware(
    {dynamic hobbies,
    dynamic interests,
    dynamic music,
    dynamic books,
    dynamic movies,
    dynamic tv_shows,
    dynamic sports,
    dynamic fitness_activites,
    dynamic cuisines,
    dynamic dress_styles}) {
  return (Store<AppState> store) async {
    store.dispatch(HobbiesInterestLoader());

    try {
      var data = await ManageProfileRepository().updateHobbies(
          hobbies: hobbies,
          interests: interests,
          music: music,
          books: books,
          movies: movies,
          tv_shows: tv_shows,
          sports: sports,
          fitness_activites: fitness_activites,
          cuisines: cuisines,
          dress_styles: dress_styles);
      store.dispatch(hobbiesInterestGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
    store.dispatch(HobbiesInterestLoader());
  };
}

ThunkAction<AppState> languageUpdateMiddleware({
  dynamic mother_tongue,
  required String known_language,
}) {
  return (Store<AppState> store) async {
    store.dispatch(LanguageSaveChanges());

    try {
      var data = await ManageProfileRepository().updateLanguage(
          mother_tongue: mother_tongue, known_language: known_language);
      store.dispatch(languageGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(LanguageSaveChanges());
  };
}

ThunkAction<AppState> life_style_update_Middleware(
    {dynamic diet, dynamic drink, dynamic smoke, dynamic living_with}) {
  return (Store<AppState> store) async {
    store.dispatch(LifeStyleSaveChanges());

    try {
      var data = await ManageProfileRepository().updateLifeStyle(
          diet: diet, drink: drink, smoke: smoke, living_with: living_with);
      store.dispatch(lifeStyleGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(LifeStyleSaveChanges());
  };
}

ThunkAction<AppState> partnerExpectationUpdateMiddleware({
  dynamic general_info,
  dynamic min_height,
  dynamic max_weight,
  dynamic residency_country,
  dynamic marital_status,
  dynamic children,
  dynamic religion,
  dynamic caste,
  dynamic subcaste,
  dynamic language,
  dynamic smoking,
  dynamic education,
  dynamic profession,
  dynamic drinking,
  dynamic diet,
  dynamic body_type,
  dynamic personal_value,
  dynamic manglik,
  dynamic pref_country,
  dynamic pref_state,
  dynamic family_val,
  dynamic complexion,
}) {
  return (Store<AppState> store) async {
    store.dispatch(Pexsave(true));

    try {
      var data = await ManageProfileRepository().updatePartnerExpectation(
          general_info: general_info,
          min_height: min_height,
          max_weight: max_weight,
          residency_country: residency_country,
          marital_status: marital_status,
          children: children,
          religion: religion,
          caste: caste,
          subcaste: subcaste,
          language: language,
          smoking: smoking,
          education: education,
          profession: profession,
          drinking: drinking,
          diet: diet,
          body_type: body_type,
          personal_value: personal_value,
          manglik: manglik,
          pref_country: pref_country,
          pref_state: pref_state,
          family_val: family_val,
          complexion: complexion);
      if (data.result) {
        store.dispatch(partnerExpectationGetMiddleware());
      }
      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(Pexsave(false));
  };
}

ThunkAction<AppState> permanentAddressUpdateMiddleware(
    {dynamic country, dynamic state, dynamic city, dynamic postal_code}) {
  return (Store<AppState> store) async {
    store.dispatch(PermanentAddressSaveChanges());

    try {
      var data = await ManageProfileRepository().updatePermanentAddress(
          country: country, state: state, city: city, postal_code: postal_code);
      store.dispatch(permanentAddressGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(PermanentAddressSaveChanges());
  };
}

ThunkAction<AppState> physicalAttrMiddleware(
    {dynamic height,
    dynamic weight,
    dynamic eye_color,
    dynamic hair_color,
    dynamic complexion,
    dynamic body_type,
    dynamic body_art,
    dynamic blood_group,
    dynamic disability}) {
  return (Store<AppState> store) async {
    store.dispatch(PhysicalAttrLoader());

    try {
      var data = await ManageProfileRepository().updatePhysicalAttr(
          height: height,
          weight: weight,
          eye_color: eye_color,
          hair_color: hair_color,
          complexion: complexion,
          body_type: body_type,
          body_art: body_art,
          blood_group: blood_group,
          disability: disability);
      store.dispatch(physicalAttributesGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
    store.dispatch(PhysicalAttrLoader());
  };
}

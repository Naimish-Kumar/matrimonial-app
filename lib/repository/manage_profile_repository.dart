import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../const/const.dart';
import '../models_response/manage_profile/get_manage_profile/astronomic_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/attitude_behavior_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/basic_Info_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/career_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/contact_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/education_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/family_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/hobbies_interest_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/introduction_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/language_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/partner_expectation_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/permanent_address_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/physical_attributes_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/present_address_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/residency_get_response.dart';
import '../models_response/manage_profile/get_manage_profile/spiritual_social_get_response.dart';
import '../screens/startup_pages/splash_screen.dart';

class ManageProfileRepository {
  // basic info

  Future<BasicInfoGetResponse> fetchBasicInfo() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/basic-info";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = basicInfoGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> basicInfoUpdate({
    required dynamic f_name,
    required dynamic l_name,
    dynamic gender,
    required dynamic dob,
    required dynamic phone,
    dynamic onbehalf,
    dynamic m_status,
    required dynamic noofChild,
    dynamic photo,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/basic-info/update";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields["first_name"] = f_name;
    request.fields["last_name"] = l_name;
    request.fields["gender"] = '$gender';
    request.fields["date_of_birth"] = dob;
    request.fields["phone"] = phone;
    if (onbehalf != null) request.fields["on_behalf"] = "$onbehalf";
    if (m_status != null)
      request.fields["marital_status"] = m_status.toString();
    request.fields["children"] = noofChild;

    // print(photo?.path != null);

    if (photo?.path != null) {
      var pic = await http.MultipartFile.fromPath("photo", (photo.path));
      request.files.add(pic);
    }

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    var data = commonResponseFromJson(responseString);
    return data;
  }

  // introduction

  Future<IntroductionGetResponse> fetchIntroduction() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/introduction";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = introductionGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> introductionUpdate({dynamic text}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/introduction-update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({"introduction": text});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // contact
  Future<ContactGetResponse> fetchContact() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/get-email";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = contactGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> contactUpdate({
    dynamic email,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/contact-info/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "email": email,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // present address
  Future<PresentAddressGetResponse> fetchPresentAddress() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/present/address";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = presentAddressGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> updatePresentAddress(
      {dynamic country,
      dynamic state,
      dynamic city,
      dynamic postal_code}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/address/update";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "address_type": "present",
      "country_id": country,
      "state_id": state,
      "city_id": city,
      "postal_code": postal_code
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  //astronomic info
  Future<AstronomicGetResponse> fetchAstronomicInfo() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/astronomic";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = astronomicGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> astronomicUpdate(
      {dynamic sunsign, dynamic moonsign, dynamic time, dynamic city}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/astronomic/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "sun_sign": sunsign,
      "moon_sign": moonsign,
      "time_of_birth": time,
      "city_of_birth": city
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // attitube interest
  Future<AttitudeBehaviorGetResponse> fetchAttitude() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/attitude-behavior";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = attitudeBehaviorGetResponseFromJson(response.body);
    return data;
  }

  // attitube interest
  Future<CommonResponse> attitudeUpdate({
    dynamic affection,
    dynamic humor,
    dynamic religious_service,
    dynamic political_views,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/attitude-behavior/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "affection": affection,
      "humor": humor,
      "religious_service": religious_service,
      "political_views": political_views,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // career
  Future<CareerGetResponse> fetchCareer() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/career";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = careerGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> careerDelete({dynamic id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/career/${id}";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.delete(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> careerCreate(
      {dynamic designation,
      dynamic company,
      dynamic start,
      dynamic end}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/career";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "designation": designation,
      "company": company,
      "start": start,
      "end": end
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> careerUpdate(
      {dynamic designation,
      dynamic company,
      dynamic start,
      dynamic end,
      dynamic id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/career/$id";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "designation": designation,
      "company": company,
      "start": start,
      "end": end,
    });

    var response = await http.put(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // caste

  // education
  Future<EducationGetResponse> fetchEducation() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/education";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = educationGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> educationDelete({dynamic id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/education/${id}";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.delete(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> educationCreate(
      {dynamic degree, dynamic institution, dynamic start, dynamic end}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/education";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "degree": degree,
      "institution": institution,
      "education_start": start,
      "education_end": end
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> educationUpdate(
      {dynamic degree,
      dynamic institution,
      dynamic start,
      dynamic end,
      dynamic id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/education/${id}";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "degree": degree,
      "institution": institution,
      "education_start": start,
      "education_end": end,
    });

    var response = await http.put(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // family get
  Future<FamilyGetResponse> fetchFamily() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/family-info";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = familyGetResponseFromJson(response.body);
    return data;
  }

  // family update
  Future<CommonResponse> updateFamily(
      {dynamic father, dynamic mother, dynamic sibling}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/family-info/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody =
        jsonEncode({"father": father, "mother": mother, "sibling": sibling});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // hobbies and interest
  Future<HobbiesInterestGetResponse> fetchHobbiesInterest() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/hobbies-interests";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = hobbiesInterestGetResponseFromJson(response.body);
    return data;
  }

  // hobbies and interest
  Future<CommonResponse> updateHobbies(
      {dynamic hobbies,
      dynamic interests,
      dynamic music,
      dynamic books,
      dynamic movies,
      dynamic tv_shows,
      dynamic sports,
      dynamic fitness_activites,
      dynamic cuisines,
      dynamic dress_styles}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/hobbies/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "hobbies": hobbies,
      "interests": interests,
      "music": music,
      "books": books,
      "movies": movies,
      "tv_shows": tv_shows,
      "sports": sports,
      "fitness_activities": fitness_activites,
      "cuisines": cuisines,
      "dress_styles": dress_styles
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // language
  Future<LanguageGetResponse> fetchLanguage() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/language";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = languageGetResponseFromJson(response.body);
    return data;
  }

  // language
  Future<CommonResponse> updateLanguage({
    dynamic mother_tongue,
    dynamic known_language,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/language/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "mothere_tongue": mother_tongue,
      "known_languages": known_language,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // life style
  Future<LifeStyleGetResponse> fetchLifeStyle() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/life-style";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = lifeStyleGetResponseFromJson(response.body);
    return data;
  }

  // life style
  Future<CommonResponse> updateLifeStyle(
      {dynamic diet, dynamic drink, dynamic smoke, dynamic living_with}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/life-style/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "diet": diet,
      "drink": drink,
      "smoke": smoke,
      "living_with": living_with
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  // partner expectation
  Future<PartnerExpectationGetResponse> fetchPartnerExpectation() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/partner-expectation";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = partnerExpectationGetResponseFromJson(response.body);
    return data;
  }

  // permanent address
  Future<PermanentGetResponse> fetchPermanentAddress() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/permanent/address";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = permanentGetResponseFromJson(response.body);

    return data;
  }

  // permanent address
  Future<CommonResponse> updatePermanentAddress(
      {dynamic country,
      dynamic state,
      dynamic city,
      dynamic postal_code}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/address/update";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "address_type": "permanent",
      "country_id": country,
      "state_id": state,
      "city_id": city,
      "postal_code": postal_code
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }

  // partner expectation

  Future<PartnerExpectationGetResponse> getPartnerExpectation() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/partner-expectation";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = partnerExpectationGetResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> updatePartnerExpectation({
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
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/partner-expectation/update";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "general": general_info,
      "partner_height": min_height,
      "partner_weight": max_weight,
      "partner_marital_status": marital_status,
      "partner_children_acceptable": children,
      "residence_country_id": residency_country,
      "partner_religion_id": religion,
      "partner_caste_id": caste,
      "partner_sub_caste_id": subcaste,
      "pertner_education": education,
      "partner_profession": profession,
      "smoking_acceptable": smoking,
      "drinking_acceptable": drinking,
      "partner_diet": diet,
      "partner_body_type": body_type,
      "partner_personal_value": personal_value,
      "partner_manglik": manglik,
      "language_id": language,
      "family_value_id": family_val,
      "partner_country_id": pref_country,
      "partner_state_id": pref_state,
      "pertner_complexion": complexion,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }

  // physical attributes
  Future<PhysicalAttributesGetResponse> fetchPhysicalAttribute() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/physical-attributes";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = physicalAttributesGetResponseFromJson(response.body);

    return data;
  }

  // physical attributes
  Future<CommonResponse> updatePhysicalAttr(
      {dynamic height,
      dynamic weight,
      dynamic eye_color,
      dynamic hair_color,
      dynamic complexion,
      dynamic body_type,
      dynamic body_art,
      dynamic blood_group,
      dynamic disability}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/physical-attributes/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "height": height,
      "weight": weight,
      "eye_color": eye_color,
      "hair_color": hair_color,
      "complexion": complexion,
      "body_type": body_type,
      "body_art": body_art,
      "blood_group": blood_group,
      "disability": disability
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }

  // residency get
  Future<ResidencyGetResponse> fetchResidency() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/residency-info";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = residencyGetResponseFromJson(response.body);

    return data;
  }

  // residency update
  Future<CommonResponse> updateResidency({
    dynamic birth_country,
    dynamic residency_country,
    dynamic growup_country,
    dynamic immigration_status,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/residency-info/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "birth_country_id": birth_country,
      "recidency_country_id": residency_country,
      "growup_country_id": growup_country,
      "immigration_status": immigration_status,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }

  // spiritual background get
  Future<SpiritualSocialGetResponse> fetchSpiritualBackground() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/spiritual-background";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = spiritualSocialGetResponseFromJson(response.body);

    return data;
  }

  // spiritual background get
  Future<CommonResponse> updateSpiritual({
    dynamic religion,
    dynamic caste,
    dynamic sub_caste,
    dynamic ethnicity,
    dynamic personal_value,
    dynamic family_value,
    dynamic community_value,
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/spiritual-background/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "member_religion_id": religion,
      "member_caste_id": caste,
      "member_sub_caste_id": sub_caste,
      "ethnicity": ethnicity,
      "personal_value": personal_value,
      "family_value_id": family_value,
      "community_value": community_value,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }
}

// To parse this JSON data, do
//
//     final partnerExpectationGetResponse = partnerExpectationGetResponseFromJson(jsonString);

import 'dart:convert';

PartnerExpectationGetResponse partnerExpectationGetResponseFromJson(
        String str) =>
    PartnerExpectationGetResponse.fromJson(json.decode(str));

String partnerExpectationGetResponseToJson(
        PartnerExpectationGetResponse data) =>
    json.encode(data.toJson());

class PartnerExpectationGetResponse {
  PartnerExpectationGetResponse({
    this.data,
  });

  Data? data;

  factory PartnerExpectationGetResponse.fromJson(Map<String, dynamic> json) =>
      PartnerExpectationGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };

  PartnerExpectationGetResponse.initialState() : data = Data.initialState();
}

class Data {
  Data({
    this.general,
    this.height,
    this.weight,
    this.maritalStatusId,
    this.childrenAcceptable,
    this.residenceCountryId,
    this.religionId,
    this.casteId,
    this.subCasteId,
    this.education,
    this.profession,
    this.smokingAcceptable,
    this.drinkingAcceptable,
    this.diet,
    this.bodyType,
    this.personalValue,
    this.manglik,
    this.languageId,
    this.familyValueId,
    this.preferredCountryId,
    this.preferredStateId,
    this.complexion,
  });

  String? general;
  dynamic height;
  dynamic weight;
  dynamic maritalStatusId;
  String? childrenAcceptable;
  String? residenceCountryId;
  String? religionId;
  String? casteId;
  String? subCasteId;
  dynamic education;
  dynamic profession;
  String? smokingAcceptable;
  String? drinkingAcceptable;
  dynamic diet;
  dynamic bodyType;
  dynamic personalValue;
  dynamic manglik;
  dynamic languageId;
  String? familyValueId;
  String? preferredCountryId;
  String? preferredStateId;
  dynamic complexion;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        general: json["general"] == null ? null : json["general"],
        height: json["height"],
        weight: json["weight"],
        maritalStatusId: json["marital_status"],
        childrenAcceptable: json["children_acceptable"] == null
            ? null
            : json["children_acceptable"],
        residenceCountryId: json["residence_country_id"] == null
            ? null
            : json["residence_country_id"],
        religionId: json["religion_id"] == null ? null : json["religion_id"],
        casteId: json["caste_id"] == null ? null : json["caste_id"],
        subCasteId: json["sub_caste_id"] == null ? null : json["sub_caste_id"],
        education: json["education"],
        profession: json["profession"],
        smokingAcceptable: json["smoking_acceptable"] == null
            ? null
            : json["smoking_acceptable"],
        drinkingAcceptable: json["drinking_acceptable"] == null
            ? null
            : json["drinking_acceptable"],
        diet: json["diet"],
        bodyType: json["body_type"],
        personalValue: json["personal_value"],
        manglik: json["manglik"],
        languageId: json["language"],
        familyValueId:
            json["family_value_id"] == null ? null : json["family_value_id"],
        preferredCountryId: json["preferred_country_id"] == null
            ? null
            : json["preferred_country_id"],
        preferredStateId: json["preferred_state_id"] == null
            ? null
            : json["preferred_state_id"],
        complexion: json["complexion"],
      );

  Map<String, dynamic> toJson() => {
        "general": general == null ? null : general,
        "height": height,
        "weight": weight,
        "marital_status": maritalStatusId,
        "children_acceptable":
            childrenAcceptable == null ? null : childrenAcceptable,
        "residence_country_id":
            residenceCountryId == null ? null : residenceCountryId,
        "religion_id": religionId == null ? null : religionId,
        "caste_id": casteId == null ? null : casteId,
        "sub_caste_id": subCasteId == null ? null : subCasteId,
        "education": education,
        "profession": profession,
        "smoking_acceptable":
            smokingAcceptable == null ? null : smokingAcceptable,
        "drinking_acceptable":
            drinkingAcceptable == null ? null : drinkingAcceptable,
        "diet": diet,
        "body_type": bodyType,
        "personal_value": personalValue,
        "manglik": manglik,
        "language": languageId,
        "family_value_id": familyValueId == null ? null : familyValueId,
        "preferred_country_id":
            preferredCountryId == null ? null : preferredCountryId,
        "preferred_state_id":
            preferredStateId == null ? null : preferredStateId,
        "complexion": complexion,
      };

  Data.initialState()
      : general = '',
        height = '',
        weight = '',
        maritalStatusId = '',
        childrenAcceptable = '',
        residenceCountryId = '',
        religionId = '',
        casteId = '',
        subCasteId = '',
        education = '',
        profession = '',
        smokingAcceptable = '',
        drinkingAcceptable = '',
        diet = '',
        bodyType = '',
        personalValue = '',
        manglik = '',
        languageId = '',
        preferredCountryId = '',
        preferredStateId = '',
        complexion = '';
}

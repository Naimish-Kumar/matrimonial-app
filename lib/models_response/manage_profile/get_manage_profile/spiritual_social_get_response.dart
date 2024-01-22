// To parse this JSON data, do
//
//     final spiritualSocialGetResponse = spiritualSocialGetResponseFromJson(jsonString);

import 'dart:convert';

SpiritualSocialGetResponse spiritualSocialGetResponseFromJson(String str) =>
    SpiritualSocialGetResponse.fromJson(json.decode(str));

String spiritualSocialGetResponseToJson(SpiritualSocialGetResponse data) =>
    json.encode(data.toJson());

class SpiritualSocialGetResponse {
  SpiritualSocialGetResponse({
    this.data,
    this.result
  });

  Data? data;
  bool? result;

  factory SpiritualSocialGetResponse.fromJson(Map<String, dynamic> json) =>
      SpiritualSocialGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
    "result": result == null ? null : result,
      };

  SpiritualSocialGetResponse.initialState() : data = Data.initialState(), result = false;
}

class Data {
  Data({
    this.religionId,
    this.casteId,
    this.subCasteId,
    this.ethnicity,
    this.personalValue,
    this.familyValueId,
    this.communityValue,
  });

  String? religionId;
  String? casteId;
  String? subCasteId;
  dynamic ethnicity;
  dynamic personalValue;
  String? familyValueId;
  dynamic communityValue;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        religionId: json["religion_id"] == null ? null : json["religion_id"],
        casteId: json["caste_id"] == null ? null : json["caste_id"],
        subCasteId: json["sub_caste_id"] == null ? null : json["sub_caste_id"],
        ethnicity: json["ethnicity"],
        personalValue: json["personal_value"],
        familyValueId:
            json["family_value_id"] == null ? null : json["family_value_id"],
        communityValue: json["community_value"],
      );

  Map<String, dynamic> toJson() => {
        "religion_id": religionId == null ? null : religionId,
        "caste_id": casteId == null ? null : casteId,
        "sub_caste_id": subCasteId == null ? null : subCasteId,
        "ethnicity": ethnicity,
        "personal_value": personalValue,
        "family_value_id": familyValueId == null ? null : familyValueId,
        "community_value": communityValue,
      };

  Data.initialState()
      : religionId = '',
        casteId = '',
        subCasteId = '',
        ethnicity = '',
        personalValue = '',
        familyValueId = '',
        communityValue = '';
}

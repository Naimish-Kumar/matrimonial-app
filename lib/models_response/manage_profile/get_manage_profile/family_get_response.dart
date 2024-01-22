// To parse this JSON data, do
//
//     final familyGetResponse = familyGetResponseFromJson(jsonString);

import 'dart:convert';

FamilyGetResponse familyGetResponseFromJson(String str) =>
    FamilyGetResponse.fromJson(json.decode(str));

String familyGetResponseToJson(FamilyGetResponse data) =>
    json.encode(data.toJson());

class FamilyGetResponse {
  FamilyGetResponse({this.data, this.result, this.message});

  FamilyData? data;
  bool? result;

  String? message;

  factory FamilyGetResponse.fromJson(Map<String, dynamic> json) =>
      FamilyGetResponse(
        data: json["data"] == null ? null : FamilyData.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };
}

class FamilyData {
  FamilyData({
    this.father,
    this.mother,
    this.sibling,
  });

  String? father;
  String? mother;
  String? sibling;

  factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
        father: json["father"] == null ? null : json["father"],
        mother: json["mother"] == null ? null : json["mother"],
        sibling: json["sibling"] == null ? null : json["sibling"],
      );

  Map<String, dynamic> toJson() => {
        "father": father == null ? null : father,
        "mother": mother == null ? null : mother,
        "sibling": sibling == null ? null : sibling,
      };
}

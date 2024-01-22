// To parse this JSON data, do
//
//     final matchedProfileResponse = matchedProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';

MatchedProfileResponse matchedProfileResponseFromJson(String str) =>
    MatchedProfileResponse.fromJson(json.decode(str));

String matchedProfileResponseToJson(MatchedProfileResponse data) =>
    json.encode(data.toJson());

class MatchedProfileResponse {
  MatchedProfileResponse({
    this.data,
  });

  List<MemberData>? data;

  factory MatchedProfileResponse.fromJson(Map<String, dynamic> json) {
    // List obj = jsonDecode(json["data"].toString());
    // obj.removeWhere((element) => element == null);
    json["data"].removeWhere((element) {
      return element == null;
    });
    return MatchedProfileResponse(
      data: List<MemberData>.from(json["data"].map((x) => MemberData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
/*
class Data {
  Data({
    this.userId,
    this.code,
    this.membership,
    this.name,
    this.photo,
    this.age,
    this.height,
    this.maritalStatus,
    this.religion,
    this.caste,
    this.subCaste,
    this.reportStatus,
    this.shortlistStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
  });

  int? userId;
  String? code;
  int? membership;
  String? name;
  String? photo;
  var age;
  var height;
  String? maritalStatus;
  String? religion;
  String? caste;
  String? subCaste;
  bool? reportStatus;
  int? shortlistStatus;
  bool? profileViewRequestStatus;
  bool? galleryViewRequestStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        code: json["code"],
        membership: json["membership"],
        name: json["name"],
        photo: json["photo"],
        age: json["age"],
        height: json["height"],
        maritalStatus: json["marital_status"],
        religion: json["religion"],
        caste: json["caste"],
        subCaste: json["sub_caste"],
        reportStatus: json["report_status"],
        shortlistStatus: json["shortlist_status"],
        profileViewRequestStatus: json["profile_view_request_status"],
        galleryViewRequestStatus: json["gallery_view_request_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "code": code,
        "membership": membership,
        "name": name,
        "photo": photo,
        "age": age,
        "height": height,
        "marital_status": maritalStatus,
        "religion": religion,
        "caste": caste,
        "sub_caste": subCaste,
        "report_status": reportStatus,
        "shortlist_status": shortlistStatus,
        "profile_view_request_status": profileViewRequestStatus,
        "gallery_view_request_status": galleryViewRequestStatus,
      };
}*/

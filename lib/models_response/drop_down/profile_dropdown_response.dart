// To parse this JSON data, do
//
//     final profiledropdownResponse = profiledropdownResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';

ProfiledropdownResponse profiledropdownResponseFromJson(String str) =>
    ProfiledropdownResponse.fromJson(json.decode(str));

String profiledropdownResponseToJson(ProfiledropdownResponse data) =>
    json.encode(data.toJson());

class ProfiledropdownResponse {
  ProfiledropdownResponse({
    this.result,
    this.data,
  });

  bool? result;
  ProfiledropdownResponseData? data;

  factory ProfiledropdownResponse.fromJson(Map<String, dynamic> json) =>
      ProfiledropdownResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : ProfiledropdownResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data!.toJson(),
      };

  ProfiledropdownResponse.initialState()
      : result = false,
        data = ProfiledropdownResponseData.init();
}

class ProfiledropdownResponseData {

  ProfiledropdownResponseData.init():

  this.onbehalfList=[],
  this.maritialStatus=[],
  this.languageList=[],
  this.religionList=[],
  this.familyValueList=[],
  this.countryList=[];

  ProfiledropdownResponseData({
    this.onbehalfList,
    this.maritialStatus,
    this.languageList,
    this.religionList,
    this.familyValueList,
    this.countryList,
  });

  List<DDown>? onbehalfList=[];
  List<DDown>? maritialStatus=[];
  List<DDown>? languageList=[];
  List<DDown>? religionList=[];
  List<DDown>? familyValueList=[];
  List<DDown>? countryList=<DDown>[];

  factory ProfiledropdownResponseData.fromJson(Map<String, dynamic> json) => ProfiledropdownResponseData(
        onbehalfList: json["onbehalf_list"] == null
            ? null
            : List<DDown>.from(
                json["onbehalf_list"].map((x) => DDown.fromJson(x))),
        maritialStatus: json["maritial_status"] == null
            ? null
            : List<DDown>.from(
                json["maritial_status"].map((x) => DDown.fromJson(x))),
        languageList: json["language_list"] == null
            ? null
            : List<DDown>.from(
                json["language_list"].map((x) => DDown.fromJson(x))),
        religionList: json["religion_list"] == null
            ? null
            : List<DDown>.from(
                json["religion_list"].map((x) => DDown.fromJson(x))),
        familyValueList: json["family_value_list"] == null
            ? null
            : List<DDown>.from(
                json["family_value_list"].map((x) => DDown.fromJson(x))),
        countryList: json["country_list"] == null
            ? null
            : List<DDown>.from(
                json["country_list"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "onbehalf_list": onbehalfList == null
            ? null
            : List<dynamic>.from(onbehalfList!.map((x) => x.toJson())),
        "maritial_status": maritialStatus == null
            ? null
            : List<dynamic>.from(maritialStatus!.map((x) => x.toJson())),
        "language_list": languageList == null
            ? null
            : List<dynamic>.from(languageList!.map((x) => x.toJson())),
        "religion_list": religionList == null
            ? null
            : List<dynamic>.from(religionList!.map((x) => x.toJson())),
        "family_value_list": familyValueList == null
            ? null
            : List<dynamic>.from(familyValueList!.map((x) => x.toJson())),
        "country_list": countryList == null
            ? null
            : List<dynamic>.from(countryList!.map((x) => x.toJson())),
      };
}



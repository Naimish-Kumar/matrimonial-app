// To parse this JSON data, do
//
//     final languageGetResponse = languageGetResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';

LanguageGetResponse languageGetResponseFromJson(String str) =>
    LanguageGetResponse.fromJson(json.decode(str));

String languageGetResponseToJson(LanguageGetResponse data) =>
    json.encode(data.toJson());

class LanguageGetResponse {
  LanguageGetResponse({
    this.result,
    this.data,
  });

  bool? result;
  Data? data;

  factory LanguageGetResponse.fromJson(Map<String, dynamic> json) =>
      LanguageGetResponse(
        result: json["result"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };

  LanguageGetResponse.initialState()
      : result = false,
        data = Data.initialState();
}

class Data {
  Data({
    this.motherTongue,
    this.knownLanguages,
  });

  MotherTongue? motherTongue;
  List<DDown>? knownLanguages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        motherTongue:json["mother_tongue"] !=null? MotherTongue.fromJson(json["mother_tongue"]):null,
        knownLanguages: json["known_languages"] == null
            ? []
            : List<DDown>.from(
                json["known_languages"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mother_tongue": motherTongue?.toJson(),
        "known_languages": knownLanguages == null
            ? []
            : List<dynamic>.from(knownLanguages!.map((x) => x.toJson())),
      };

  Data.initialState()
      : motherTongue = MotherTongue.initialState(),
        knownLanguages = [];
}

class MotherTongue {
  MotherTongue({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory MotherTongue.fromJson(Map<String, dynamic> json) => MotherTongue(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  MotherTongue.initialState()
      : id = 0,
        name = '';
}

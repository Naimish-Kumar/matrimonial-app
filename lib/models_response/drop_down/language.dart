// To parse this JSON data, do
//
//     final languageResponse = languageResponseFromJson(jsonString);

import 'dart:convert';

LanguageResponse languageResponseFromJson(String str) =>
    LanguageResponse.fromJson(json.decode(str));

String languageResponseToJson(LanguageResponse data) =>
    json.encode(data.toJson());

class LanguageResponse {
  LanguageResponse({
    this.data,
  });

  List<Data>? data;

  factory LanguageResponse.fromJson(Map<String, dynamic> json) =>
      LanguageResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  LanguageResponse.initialState() : data = [];
}

class Data {
  Data({
    this.name,
  });

  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };

  Data.initialState() : name = '';
}

// To parse this JSON data, do
//
//     final lifeStyleGetResponse = lifeStyleGetResponseFromJson(jsonString);

import 'dart:convert';

LifeStyleGetResponse lifeStyleGetResponseFromJson(String str) =>
    LifeStyleGetResponse.fromJson(json.decode(str));

String lifeStyleGetResponseToJson(LifeStyleGetResponse data) =>
    json.encode(data.toJson());

class LifeStyleGetResponse {
  LifeStyleGetResponse({
    this.data,
    this.result
  });

  Data? data;
  bool? result;

  factory LifeStyleGetResponse.fromJson(Map<String, dynamic> json) =>
      LifeStyleGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
    "result": result == null ? null : result,
      };

  LifeStyleGetResponse.initialState() : data = Data.initialState(), result = false;
}

class Data {
  Data({
    this.diet,
    this.drink,
    this.smoke,
    this.livingWith,
  });

  String? diet;
  String? drink;
  String? smoke;
  String? livingWith;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        diet: json["diet"] == null ? null : json["diet"],
        drink: json["drink"] == null ? null : json["drink"],
        smoke: json["smoke"] == null ? null : json["smoke"],
        livingWith: json["living_with"] == null ? null : json["living_with"],
      );

  Map<String, dynamic> toJson() => {
        "diet": diet == null ? null : diet,
        "drink": drink == null ? null : drink,
        "smoke": smoke == null ? null : smoke,
        "living_with": livingWith == null ? null : livingWith,
      };

  Data.initialState()
      : diet = '',
        drink = '',
        smoke = '',
        livingWith = '';
}

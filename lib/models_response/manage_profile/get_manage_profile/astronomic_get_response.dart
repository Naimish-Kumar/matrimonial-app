// To parse this JSON data, do
//
//     final astronomicGetResponse = astronomicGetResponseFromJson(jsonString);

import 'dart:convert';

AstronomicGetResponse astronomicGetResponseFromJson(String str) =>
    AstronomicGetResponse.fromJson(json.decode(str));

String astronomicGetResponseToJson(AstronomicGetResponse data) =>
    json.encode(data.toJson());

class AstronomicGetResponse {
  AstronomicGetResponse({
    this.data,
    this.result,
  });

  Data? data;
  bool? result;

  factory AstronomicGetResponse.fromJson(Map<String, dynamic> json) =>
      AstronomicGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "result": result == null ? null : result,
      };

  AstronomicGetResponse.initialState()
      : data = Data.initialState(),
        result = false;
}

class Data {
  Data({
    this.sunSign,
    this.moonSign,
    this.timeOfBirth,
    this.cityOfBirth,
  });

  String? sunSign;
  String? moonSign;
  var timeOfBirth;
  var cityOfBirth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sunSign: json["sun_sign"] == null ? null : json["sun_sign"],
        moonSign: json["moon_sign"] == null ? null : json["moon_sign"],
        timeOfBirth:
            json["time_of_birth"] == null ? null : json["time_of_birth"],
        cityOfBirth:
            json["city_of_birth"] == null ? null : json["city_of_birth"],
      );

  Map<String, dynamic> toJson() => {
        "sun_sign": sunSign == null ? null : sunSign,
        "moon_sign": moonSign == null ? null : moonSign,
        "time_of_birth": timeOfBirth == null ? null : timeOfBirth,
        "city_of_birth": cityOfBirth == null ? null : cityOfBirth,
      };

  Data.initialState()
      : sunSign = '',
        moonSign = '',
        timeOfBirth = '',
        cityOfBirth = '';
}

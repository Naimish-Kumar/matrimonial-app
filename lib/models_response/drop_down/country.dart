// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

CountryResponse countryResponseFromJson(String str) =>
    CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) =>
    json.encode(data.toJson());

class CountryResponse {
  CountryResponse({
    this.data,
  });

  List<Data>? data;

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  CountryResponse.initialState() : data = [];
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

// To parse this JSON data, do
//
//     final maritalStatusResponse = maritalStatusResponseFromJson(jsonString);

import 'dart:convert';

MaritalStatusResponse maritalStatusResponseFromJson(String str) =>
    MaritalStatusResponse.fromJson(json.decode(str));

String maritalStatusResponseToJson(MaritalStatusResponse data) =>
    json.encode(data.toJson());

class MaritalStatusResponse {
  MaritalStatusResponse({
    this.data,
  });

  List<Data>? data;

  factory MaritalStatusResponse.fromJson(Map<String, dynamic> json) =>
      MaritalStatusResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  MaritalStatusResponse.initialState() : data = [];
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

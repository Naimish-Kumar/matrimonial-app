// To parse this JSON data, do
//
//     final familyResponse = familyResponseFromJson(jsonString);

import 'dart:convert';

FamilyResponse familyResponseFromJson(String str) =>
    FamilyResponse.fromJson(json.decode(str));

String familyResponseToJson(FamilyResponse data) => json.encode(data.toJson());

class FamilyResponse {
  FamilyResponse({
    this.data,
  });

  List<Data>? data;

  factory FamilyResponse.fromJson(Map<String, dynamic> json) =>
      FamilyResponse(
        data: json["data"] == null ? null : List<Data>.from(
            json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "data": data == null ? null : List<dynamic>.from(
            data!.map((x) => x.toJson())),
      };

  FamilyResponse.initialState() : data = [];

}

class Data {
  Data({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };

  Data.initialState() : name = '', id = 0;

}

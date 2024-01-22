// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';

CityResponse cityResponseFromJson(String str) =>
    CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  CityResponse({
    this.data,
  });

  List<DDown>? data;

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  CityResponse.initialState() : data = [];
}

class Data {
  Data({this.name, this.id});

  int? id;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };

  Data.initialState()
      : name = '',
        id = 0;
}

// To parse this JSON data, do
//
//     final stateResponse = stateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';

StateResponse stateResponseFromJson(String str) =>
    StateResponse.fromJson(json.decode(str));

String stateResponseToJson(StateResponse data) => json.encode(data.toJson());

class StateResponse {
  StateResponse({
    this.data,
  });

  List<DDown>? data;

  factory StateResponse.fromJson(Map<String, dynamic> json) => StateResponse(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  StateResponse.initialState() : data = [];
}
class StateResponseFromPartnerPref {
  StateResponseFromPartnerPref({
    this.data,
  });

  List<DDown>? data;

  factory StateResponseFromPartnerPref.fromJson(Map<String, dynamic> json) => StateResponseFromPartnerPref(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  StateResponseFromPartnerPref.initialState() : data = [];
}

class Data {
  Data({
    this.id,
    this.name,
  });

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
      : id = 0,
        name = '';
}

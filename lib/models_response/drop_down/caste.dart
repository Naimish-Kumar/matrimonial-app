// To parse this JSON data, do
//
//     final casteResponse = casteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';

CasteResponse casteResponseFromJson(String str) =>
    CasteResponse.fromJson(json.decode(str));

String casteResponseToJson(CasteResponse data) => json.encode(data.toJson());

class CasteResponse {
  CasteResponse({
    this.data,
  });

  List<DDown>? data;

  factory CasteResponse.fromJson(Map<String, dynamic> json) => CasteResponse(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  CasteResponse.initialState() : data = [];
}
class CasteResponseForPartnerPref {
  CasteResponseForPartnerPref({
    this.data,
  });

  List<DDown>? data;

  factory CasteResponseForPartnerPref.fromJson(Map<String, dynamic> json) => CasteResponseForPartnerPref(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  CasteResponseForPartnerPref.initialState() : data = [];
}



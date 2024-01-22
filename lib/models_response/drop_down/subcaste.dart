// To parse this JSON data, do
//
//     final subcasteResponse = subcasteResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';

SubcasteResponse subcasteResponseFromJson(String str) =>
    SubcasteResponse.fromJson(json.decode(str));

String subcasteResponseToJson(SubcasteResponse data) =>
    json.encode(data.toJson());

class SubcasteResponse {
  SubcasteResponse({
    this.data,
  });

  List<DDown>? data;

  factory SubcasteResponse.fromJson(Map<String, dynamic> json) =>
      SubcasteResponse(
        data: json["data"] == null
            ? null
            : List<DDown>.from(json["data"].map((x) => DDown.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  SubcasteResponse.initialState() : data = [];
}



// To parse this JSON data, do
//
//     final newMembersResponse = newMembersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';

NewMembersResponse newMembersResponseFromJson(String str) =>
    NewMembersResponse.fromJson(json.decode(str));

String newMembersResponseToJson(NewMembersResponse data) =>
    json.encode(data.toJson());

class NewMembersResponse {
  NewMembersResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<MemberData>? data;

  factory NewMembersResponse.fromJson(Map<String, dynamic> json) =>
      NewMembersResponse(
        result: json["result"],
        data: List<MemberData>.from(json["data"].map((x) => MemberData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}



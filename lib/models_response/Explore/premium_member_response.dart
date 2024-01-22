// To parse this JSON data, do
//
//     final premiumMembersResponse = premiumMembersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';

PremiumMembersResponse premiumMembersResponseFromJson(String str) =>
    PremiumMembersResponse.fromJson(json.decode(str));

String premiumMembersResponseToJson(PremiumMembersResponse data) =>
    json.encode(data.toJson());

class PremiumMembersResponse {
  PremiumMembersResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<MemberData>? data;

  factory PremiumMembersResponse.fromJson(Map<String, dynamic> json) =>
      PremiumMembersResponse(
        result: json["result"],
        data: List<MemberData>.from(json["data"].map((x) => MemberData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}



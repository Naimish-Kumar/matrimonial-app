// To parse this JSON data, do
//
//     final isApprovedResponse = isApprovedResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final isApprovedResponse = isApprovedResponseFromJson(jsonString);

import 'dart:convert';

IsApprovedResponse isApprovedResponseFromJson(String str) =>
    IsApprovedResponse.fromJson(json.decode(str));

String isApprovedResponseToJson(IsApprovedResponse data) =>
    json.encode(data.toJson());

class IsApprovedResponse {
  int? isApproved;
  bool? verificationInfo;

  IsApprovedResponse({
    this.isApproved,
    this.verificationInfo,
  });

  factory IsApprovedResponse.fromJson(Map<String, dynamic> json) =>
      IsApprovedResponse(
        isApproved: json["is_approved"],
        verificationInfo: json["verification_info"],
      );

  Map<String, dynamic> toJson() => {
        "is_approved": isApproved,
        "verification_info": verificationInfo,
      };
}

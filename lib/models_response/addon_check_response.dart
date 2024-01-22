// To parse this JSON data, do
//
//     final addonCheckResponse = addonCheckResponseFromJson(jsonString);

import 'dart:convert';

AddonCheckResponse addonCheckResponseFromJson(String str) =>
    AddonCheckResponse.fromJson(json.decode(str));

String addonCheckResponseToJson(AddonCheckResponse data) =>
    json.encode(data.toJson());

class AddonCheckResponse {
  AddonCheckResponse({
    this.result,
    this.data,
  });

  bool? result;
  AddonData? data;

  factory AddonCheckResponse.fromJson(Map<String, dynamic> json) =>
      AddonCheckResponse(
        result: json["result"],
        data: AddonData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };
}

class AddonData {
  AddonData({
    this.otpSystem,
    this.referralSystem,
    this.supportTickets,
  });

  bool? otpSystem;
  bool? referralSystem;
  bool? supportTickets;

  factory AddonData.fromJson(Map<String, dynamic> json) => AddonData(
        otpSystem: json["otp_system"],
        referralSystem: json["referral_system"],
        supportTickets: json["support_tickets"],
      );

  Map<String, dynamic> toJson() => {
        "otp_system": otpSystem,
        "referral_system": referralSystem,
        "support_tickets": supportTickets,
      };
}

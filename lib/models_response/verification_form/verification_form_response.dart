// To parse this JSON data, do
//
//     final verificationFormResponse = verificationFormResponseFromJson(jsonString);

import 'dart:convert';

List<VerificationFormResponse> verificationFormResponseFromJson(String str) =>
    List<VerificationFormResponse>.from(
        json.decode(str).map((x) => VerificationFormResponse.fromJson(x)));

String verificationFormResponseToJson(List<VerificationFormResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerificationFormResponse {
  String? type;
  String? label;
  String? options;

  VerificationFormResponse({
    this.type,
    this.label,
    this.options,
  });

  factory VerificationFormResponse.fromJson(Map<String, dynamic> json) =>
      VerificationFormResponse(
        type: json["type"],
        label: json["label"],
        options: json["options"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "options": options,
      };
}

// To parse this JSON data, do
//
//     final tokenUpdateResponse = tokenUpdateResponseFromJson(jsonString);

import 'dart:convert';

TokenUpdateResponse tokenUpdateResponseFromJson(String str) =>
    TokenUpdateResponse.fromJson(json.decode(str));

String tokenUpdateResponseToJson(TokenUpdateResponse data) =>
    json.encode(data.toJson());

class TokenUpdateResponse {
  bool? result;
  String? message;

  TokenUpdateResponse({
    this.result,
    this.message,
  });

  factory TokenUpdateResponse.fromJson(Map<String, dynamic> json) =>
      TokenUpdateResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}

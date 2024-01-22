// To parse this JSON data, do
//
//     final commonResponse = commonResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    this.result=false,
    this.message,
    this.errors
  });

  bool result;
  var errors;
  var message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        result: json["result"]??false ,
        message: json["message"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "result": result ,
        "message": message == null ? null : message,
      };
}

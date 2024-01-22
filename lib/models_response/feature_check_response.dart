// To parse this JSON data, do
//
//     final systemSettingResponse = systemSettingResponseFromJson(jsonString);

import 'dart:convert';

SystemSettingResponse systemSettingResponseFromJson(String str) => SystemSettingResponse.fromJson(json.decode(str));

String systemSettingResponseToJson(SystemSettingResponse data) => json.encode(data.toJson());

class SystemSettingResponse {
  bool? result;
  Map<String, dynamic>? data;

  SystemSettingResponse({
    this.result,
    this.data,
  });

  factory SystemSettingResponse.fromJson(Map<String, dynamic> json) => SystemSettingResponse(
    result: json["result"],
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, String?>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

// To parse this JSON data, do
//
//     final trustedByMillionsResponse = trustedByMillionsResponseFromJson(jsonString);

import 'dart:convert';

TrustedByMillionsResponse trustedByMillionsResponseFromJson(String str) =>
    TrustedByMillionsResponse.fromJson(json.decode(str));

String trustedByMillionsResponseToJson(TrustedByMillionsResponse data) =>
    json.encode(data.toJson());

class TrustedByMillionsResponse {
  TrustedByMillionsResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<Data>? data;

  factory TrustedByMillionsResponse.fromJson(Map<String, dynamic> json) =>
      TrustedByMillionsResponse(
        result: json["result"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.title,
    this.icon,
  });

  String? title;
  String? icon;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
      };
}

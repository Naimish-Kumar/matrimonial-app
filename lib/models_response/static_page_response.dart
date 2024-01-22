// To parse this JSON data, do
//
//     final staticPageResponse = staticPageResponseFromJson(jsonString);

import 'dart:convert';

StaticPageResponse staticPageResponseFromJson(String str) =>
    StaticPageResponse.fromJson(json.decode(str));

String staticPageResponseToJson(StaticPageResponse data) =>
    json.encode(data.toJson());

class StaticPageResponse {
  List<Datum>? data;

  StaticPageResponse({
    this.data,
  });

  factory StaticPageResponse.fromJson(Map<String, dynamic> json) =>
      StaticPageResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? title;
  String? content;

  Datum({
    this.title,
    this.content,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}

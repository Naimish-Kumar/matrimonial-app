// To parse this JSON data, do
//
//     final onbehalfResponse = onbehalfResponseFromJson(jsonString);

import 'dart:convert';

OnbehalfResponse onbehalfResponseFromJson(String str) =>
    OnbehalfResponse.fromJson(json.decode(str));

String onbehalfResponseToJson(OnbehalfResponse data) =>
    json.encode(data.toJson());

class OnbehalfResponse {
  OnbehalfResponse({
    this.data,
  });

  List<Data>? data;

  factory OnbehalfResponse.fromJson(Map<String, dynamic> json) =>
      OnbehalfResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

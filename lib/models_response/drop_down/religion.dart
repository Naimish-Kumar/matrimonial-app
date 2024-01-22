// To parse this JSON data, do
//
//     final religionResponse = religionResponseFromJson(jsonString);

import 'dart:convert';

ReligionResponse religionResponseFromJson(String str) => ReligionResponse.fromJson(json.decode(str));

String religionResponseToJson(ReligionResponse data) => json.encode(data.toJson());

class ReligionResponse {
  ReligionResponse({
    this.data,
  });

  List<Data>? data;

  factory ReligionResponse.fromJson(Map<String, dynamic> json) => ReligionResponse(
    data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  ReligionResponse.initialState() : data = [];
}

class Data {
  Data({
    this.name,
  });

  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };

  Data.initialState() : name = '';

}

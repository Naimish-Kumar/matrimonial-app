// To parse this JSON data, do
//
//     final careerGetResponse = careerGetResponseFromJson(jsonString);

import 'dart:convert';

CareerGetResponse careerGetResponseFromJson(String str) =>
    CareerGetResponse.fromJson(json.decode(str));

String careerGetResponseToJson(CareerGetResponse data) =>
    json.encode(data.toJson());

class CareerGetResponse {
  CareerGetResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory CareerGetResponse.fromJson(Map<String, dynamic> json) =>
      CareerGetResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };

  CareerGetResponse.initialState()
      : data = [],
        result = false;
}

class Data {
  Data({
    this.id,
    this.designation,
    this.company,
    this.start,
    this.end,
    this.present,
  });

  int? id;
  String? designation;
  String? company;
  int? start;
  dynamic end;
  dynamic present;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        designation: json["designation"],
        company: json["company"],
        start: json["start"],
        end: json["end"],
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "company": company,
        "start": start,
        "end": end,
        "present": present,
      };

  Data.initialState()
      : id = 0,
        designation = '',
        company = '',
        start = 0,
        end = 0,
        present = false;
}

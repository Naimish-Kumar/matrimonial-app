// To parse this JSON data, do
//
//     final educationGetResponse = educationGetResponseFromJson(jsonString);

import 'dart:convert';

EducationGetResponse educationGetResponseFromJson(String str) =>
    EducationGetResponse.fromJson(json.decode(str));

String educationGetResponseToJson(EducationGetResponse data) =>
    json.encode(data.toJson());

class EducationGetResponse {
  EducationGetResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory EducationGetResponse.fromJson(Map<String, dynamic> json) =>
      EducationGetResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };

  EducationGetResponse.initialState()
      : data = [],
        result = false;
}

class Data {
  Data({
    this.id,
    this.degree,
    this.institution,
    this.start,
    this.end,
    this.present,
  });

  int? id;
  String? degree;
  String? institution;
  int? start;
  int? end;
  bool? present;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        degree: json["degree"],
        institution: json["institution"],
        start: json["start"],
        end: json["end"],
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "degree": degree,
        "institution": institution,
        "start": start,
        "end": end,
        "present": present,
      };

  Data.initialState()
      : degree = '',
        institution = '',
        start = 0,
        id = 0,
        present = false,
        end = 0;
}

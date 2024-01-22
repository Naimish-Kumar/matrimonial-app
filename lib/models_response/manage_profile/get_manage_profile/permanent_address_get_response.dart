// To parse this JSON data, do
//
//     final permanentGetResponse = permanentGetResponseFromJson(jsonString);

import 'dart:convert';

PermanentGetResponse permanentGetResponseFromJson(String str) =>
    PermanentGetResponse.fromJson(json.decode(str));

String permanentGetResponseToJson(PermanentGetResponse data) =>
    json.encode(data.toJson());

class PermanentGetResponse {
  PermanentGetResponse({
    this.data,
    this.result
  });

  Data? data;
  bool? result;

  factory PermanentGetResponse.fromJson(Map<String, dynamic> json) =>
      PermanentGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
    "result": result == null ? null : result,
      };

  PermanentGetResponse.initialState() : data = Data.initialState(), result = false;
}

class Data {
  Data({
    this.country,
    this.state,
    this.city,
    this.postalCode,
  });

  String? country;
  String? state;
  String? city;
  String? postalCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "postal_code": postalCode == null ? null : postalCode,
      };

  Data.initialState()
      : country = '',
        state = '',
        city = '',
        postalCode = '';
}

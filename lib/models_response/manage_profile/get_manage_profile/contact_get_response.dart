// To parse this JSON data, do
//
//     final contactGetResponse = contactGetResponseFromJson(jsonString);

import 'dart:convert';

ContactGetResponse contactGetResponseFromJson(String str) =>
    ContactGetResponse.fromJson(json.decode(str));

String contactGetResponseToJson(ContactGetResponse data) =>
    json.encode(data.toJson());

class ContactGetResponse {
  ContactGetResponse({
    this.result,
    this.data,
  });

  bool? result;
  ContactData? data;

  factory ContactGetResponse.fromJson(Map<String, dynamic> json) =>
      ContactGetResponse(
        result: json["result"],
        data: ContactData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };
}

class ContactData {
  ContactData({
    this.email,
  });

  String? email;

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

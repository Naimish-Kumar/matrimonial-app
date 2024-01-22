// To parse this JSON data, do
//
//     final myTicketStoreResponse = myTicketStoreResponseFromJson(jsonString);

import 'dart:convert';

MyTicketStoreResponse myTicketStoreResponseFromJson(String str) =>
    MyTicketStoreResponse.fromJson(json.decode(str));

String myTicketStoreResponseToJson(MyTicketStoreResponse data) =>
    json.encode(data.toJson());

class MyTicketStoreResponse {
  MyTicketStoreResponse({
    this.result,
    this.data,
  });

  bool? result;
  String? data;

  factory MyTicketStoreResponse.fromJson(Map<String, dynamic> json) =>
      MyTicketStoreResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data,
      };
}

// To parse this JSON data, do
//
//     final ticketReplyResponse = ticketReplyResponseFromJson(jsonString);

import 'dart:convert';

TicketReplyResponse ticketReplyResponseFromJson(String str) =>
    TicketReplyResponse.fromJson(json.decode(str));

String ticketReplyResponseToJson(TicketReplyResponse data) =>
    json.encode(data.toJson());

class TicketReplyResponse {
  TicketReplyResponse({
    this.result,
    this.message,
  });

  bool? result;
  String? message;

  factory TicketReplyResponse.fromJson(Map<String, dynamic> json) =>
      TicketReplyResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  TicketReplyResponse.initialState()
      : result = false,
        message = '';
}

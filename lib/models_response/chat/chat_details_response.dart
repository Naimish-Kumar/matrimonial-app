// To parse this JSON data, do
//
//     final chatDetailsResponse = chatDetailsResponseFromJson(jsonString);

import 'dart:convert';

ChatDetailsResponse chatDetailsResponseFromJson(String str) => ChatDetailsResponse.fromJson(json.decode(str));

String chatDetailsResponseToJson(ChatDetailsResponse data) => json.encode(data.toJson());

class ChatDetailsResponse {
  ChatDetailsData? data;
  bool? result;

  ChatDetailsResponse({
    this.data,
    this.result,
  });

  factory ChatDetailsResponse.fromJson(Map<String, dynamic> json) => ChatDetailsResponse(
    data: json["data"] == null ? null : ChatDetailsData.fromJson(json["data"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "result": result,
  };
}

class ChatDetailsData {
  String? receiverName;
  String? receiverPhoto;
  String? senderName;
  String? authUserPhoto;
  List<Message>? messages;

  ChatDetailsData({
    this.receiverName,
    this.receiverPhoto,
    this.senderName,
    this.authUserPhoto,
    this.messages,
  });

  factory ChatDetailsData.fromJson(Map<String, dynamic> json) => ChatDetailsData(
    receiverName: json["receiver_name"],
    receiverPhoto: json["receiver_photo"],
    senderName: json["sender_name"],
    authUserPhoto: json["auth_user_photo"],
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receiver_name": receiverName,
    "receiver_photo": receiverPhoto,
    "sender_name": senderName,
    "auth_user_photo": authUserPhoto,
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class Message {
  int? id;
  int? chatThreadId;
  int? senderUserId;
  String? message;
  List<Attachment>? attachment;
  int? seen;
  String? attachmentType;

  Message({
    this.id,
    this.chatThreadId,
    this.senderUserId,
    this.message,
    this.attachment,
    this.seen,
    this.attachmentType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    chatThreadId: json["chat_thread_id"],
    senderUserId: json["sender_user_id"],
    message: json["message"],
    attachment: json["attachment"] == null ? [] : List<Attachment>.from(json["attachment"]!.map((x) => Attachment.fromJson(x))),
    seen: json["seen"],
    attachmentType: json["attachment_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_thread_id": chatThreadId,
    "sender_user_id": senderUserId,
    "message": message,
    "attachment": attachment,
    "seen": seen,
  };
}


class Attachment {
  String? attachment;
  String? attachmentType;
  String? extension;
  String? fileName;

  Attachment({
    this.attachment,
    this.attachmentType,
    this.extension,
    this.fileName,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachment: json["attachment"],
    attachmentType: json["attachment_type"],
    extension: json["extension"],
    fileName: json["file_name"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "attachment_type": attachmentType,
    "extension": extension,
    "file_name": fileName,
  };
}

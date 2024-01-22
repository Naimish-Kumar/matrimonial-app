// To parse this JSON data, do
//
//     final myTicketResponse = myTicketResponseFromJson(jsonString);

import 'dart:convert';

MyTicketResponse myTicketResponseFromJson(String str) =>
    MyTicketResponse.fromJson(json.decode(str));

String myTicketResponseToJson(MyTicketResponse data) =>
    json.encode(data.toJson());

class MyTicketResponse {
  MyTicketResponse({
    this.data,
    this.links,
    this.meta,
    this.result,
  });

  List<Data>? data;
  Links? links;
  Meta? meta;
  bool? result;

  factory MyTicketResponse.fromJson(Map<String, dynamic> json) =>
      MyTicketResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
        "result": result,
      };
}

class Data {
  Data({
    this.id,
    this.ticketId,
    this.status,
    this.subject,
    this.attachments,
    this.description,
    this.supportCategoryName,
    this.createdAt,
    this.reply,
  });

  int? id;
  String? ticketId;
  int? status;
  String? subject;
  String? attachments;
  String? description;
  String? supportCategoryName;
  DateTime? createdAt;
  List<Reply>? reply;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        ticketId: json["ticket_id"],
        status: json["status"],
        attachments: json["attachments"],
        subject: json["subject"],
        description: json["description"],
        supportCategoryName: json["support_category_name"],
        createdAt: DateTime.parse(json["created_at"]),
        reply: List<Reply>.from(json["reply"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "status": status,
        "subject": subject,
        "attachments": attachments,
        "description": description,
        "support_category_name": supportCategoryName,
        "created_at": createdAt!.toIso8601String(),
        "reply": List<dynamic>.from(reply!.map((x) => x.toJson())),
      };

}

class Reply {
  Reply({
    this.reply,
    this.repliedUserImage,
    this.replyAttachment,
    this.createdAt,
  });

  String? reply;
  String? repliedUserImage;
  String? replyAttachment;
  DateTime? createdAt;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        reply: json["reply"],
        repliedUserImage: json["replied_user_image"],
        replyAttachment: json["reply_attachment"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "reply": reply,
        "replied_user_image": repliedUserImage,
        "reply_attachment": replyAttachment,
        "created_at": createdAt!.toIso8601String(),
      };

}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };

}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };

}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

// To parse this JSON data, do
//
//     final notificationsGetResponse = notificationsGetResponseFromJson(jsonString);

import 'dart:convert';

NotificationsGetResponse notificationsGetResponseFromJson(String str) =>
    NotificationsGetResponse.fromJson(json.decode(str));

String notificationsGetResponseToJson(NotificationsGetResponse data) =>
    json.encode(data.toJson());

class NotificationsGetResponse {
  NotificationsGetResponse({
    this.data,
    this.links,
    this.meta,
    this.result,
  });

  List<NotificationData>? data;
  Links? links;
  Meta? meta;
  bool? result;

  factory NotificationsGetResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsGetResponse(
        data: json["data"] == null
            ? null
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links == null ? null : links!.toJson(),
        "meta": meta == null ? null : meta!.toJson(),
        "result": result == null ? null : result,
      };
}

class NotificationData {
  NotificationData({
    this.check,
    this.notificationId,
    this.type,
    this.notifyBy,
    this.photo,
    this.message,
    this.time,
    this.readAt,
  });

  bool? check;
  int? notificationId;
  String? type;
  int? notifyBy;
  String? photo;
  String? message;
  String? time;
  String? readAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        check: json["check"] == null ? null : json["check"],
        notificationId:
            json["notification_id"] == null ? null : json["notification_id"],
        type: json["type"] == null ? null : json["type"],
        notifyBy: json["notify_by"] == null ? null : json["notify_by"],
        photo: json["photo"] == null ? null : json["photo"],
        message: json["message"] == null ? null : json["message"],
        time: json["time"] == null ? null : json["time"],
        readAt: json["read_at"] == null ? null : json["read_at"],
      );

  Map<String, dynamic> toJson() => {
        "check": check == null ? null : check,
        "notification_id": notificationId == null ? null : notificationId,
        "type": type == null ? null : type,
        "photo": photo == null ? null : photo,
        "notify_by": notifyBy == null ? null : notifyBy,
        "message": message == null ? null : message,
        "time": time == null ? null : time,
        "read_at": readAt == null ? null : readAt,
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
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next == null ? null : next,
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
        currentPage: json["current_page"] == null ? null : json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
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
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}

// To parse this JSON data, do
//
//     final happyStoriesResponse = happyStoriesResponseFromJson(jsonString);

import 'dart:convert';

HappyStoriesResponse happyStoriesResponseFromJson(String str) =>
    HappyStoriesResponse.fromJson(json.decode(str));

String happyStoriesResponseToJson(HappyStoriesResponse data) =>
    json.encode(data.toJson());

class HappyStoriesResponse {
  HappyStoriesResponse({
    this.data,
    this.links,
    this.meta,
    this.result,
  });

  List<Data>? data;
  Links? links;
  Meta? meta;
  bool? result;

  factory HappyStoriesResponse.fromJson(Map<String, dynamic> json) =>
      HappyStoriesResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
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

class Data {
  Data({
    this.id,
    this.userId,
    this.packageUpdateAlert,
    this.userFirstName,
    this.userLastName,
    this.partnerName,
    this.title,
    this.details,
    this.date,
    this.thumbImg,
    this.photos,
    this.videoProvider,
    this.videoLink,
  });

  int? id;
  int? userId;
  bool? packageUpdateAlert;
  String? userFirstName;
  String? userLastName;
  String? partnerName;
  String? title;
  String? details;
  String? date;
  String? thumbImg;
  List<String>? photos;
  String? videoProvider;
  String? videoLink;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        packageUpdateAlert: json["package_update_alert"] == null
            ? null
            : json["package_update_alert"],
        userFirstName:
            json["user_first_name"] == null ? null : json["user_first_name"],
        userLastName:
            json["user_last_name"] == null ? null : json["user_last_name"],
        partnerName: json["partner_name"] == null ? null : json["partner_name"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        date: json["date"] == null ? null : json["date"],
        thumbImg: json["thumb_img"] == null ? null : json["thumb_img"],
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        videoProvider:
            json["video_provider"] == null ? null : json["video_provider"],
        videoLink: json["video_link"] == null ? null : json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "package_update_alert":
            packageUpdateAlert == null ? null : packageUpdateAlert,
        "user_first_name": userFirstName == null ? null : userFirstName,
        "user_last_name": userLastName == null ? null : userLastName,
        "partner_name": partnerName == null ? null : partnerName,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "date": date == null ? null : date,
        "thumb_img": thumbImg == null ? null : thumbImg,
        "photos":
            photos == null ? null : List<dynamic>.from(photos!.map((x) => x)),
        "video_provider": videoProvider == null ? null : videoProvider,
        "video_link": videoLink == null ? null : videoLink,
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
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
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

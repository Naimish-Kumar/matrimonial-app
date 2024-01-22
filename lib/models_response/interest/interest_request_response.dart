// To parse this JSON data, do
//
//     final interestRequestResponse = interestRequestResponseFromJson(jsonString);

import 'dart:convert';

InterestRequestResponse interestRequestResponseFromJson(String str) =>
    InterestRequestResponse.fromJson(json.decode(str));

String interestRequestResponseToJson(InterestRequestResponse data) =>
    json.encode(data.toJson());

class InterestRequestResponse {
  InterestRequestResponse({
    this.data,
    this.links,
    this.meta,
    this.result,
  });

  List<Data>? data;
  Links? links;
  Meta? meta;
  bool? result;

  factory InterestRequestResponse.fromJson(Map<String, dynamic> json) {
    json["data"].removeWhere((element) {
      return element == null;
    });
    return InterestRequestResponse(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      links: Links.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
      result: json["result"],
    );
  }

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
    this.userId,
    this.packageUpdateAlert,
    this.photo,
    this.name,
    this.age,
    this.status,
    this.country,
    this.religion,
    this.mothereTongue,
  });

  int? id;
  int? userId;
  bool? packageUpdateAlert;
  String? photo;
  String? name;
  int? age;
  String? status;
  String? country;
  String? religion;
  String? mothereTongue;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        packageUpdateAlert: json["package_update_alert"],
        photo: json["photo"],
        name: json["name"],
        age: json["age"],
        status: json["status"],
        country: json["country"],
        religion: json["religion"],
        mothereTongue: json["mothere_tongue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "package_update_alert": packageUpdateAlert,
        "photo": photo,
        "name": name,
        "age": age,
        "status": status,
        "country": country,
        "religion": religion,
        "mothere_tongue": mothereTongue,
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

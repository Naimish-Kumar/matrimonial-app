// To parse this JSON data, do
//
//     final eHappyStoriesResponse = eHappyStoriesResponseFromJson(jsonString);

import 'dart:convert';

EHappyStoriesResponse eHappyStoriesResponseFromJson(String str) =>
    EHappyStoriesResponse.fromJson(json.decode(str));

String eHappyStoriesResponseToJson(EHappyStoriesResponse data) =>
    json.encode(data.toJson());

class EHappyStoriesResponse {
  EHappyStoriesResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<Datum>? data;

  factory EHappyStoriesResponse.fromJson(Map<String, dynamic> json) =>
      EHappyStoriesResponse(
        result: json["result"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        packageUpdateAlert: json["package_update_alert"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        partnerName: json["partner_name"],
        title: json["title"],
        details: json["details"],
        date: json["date"],
        thumbImg: json["thumb_img"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "package_update_alert": packageUpdateAlert,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "partner_name": partnerName,
        "title": title,
        "details": details,
        "date": date,
        "thumb_img": thumbImg,
        "photos": List<dynamic>.from(photos!.map((x) => x)),
        "video_provider": videoProvider,
        "video_link": videoLink,
      };
}

// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

import 'dart:convert';

BannerResponse bannerResponseFromJson(String str) =>
    BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
  BannerResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<Data>? data;

  factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        result: json["result"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.link,
    this.image,
  });

  String? link;
  String? image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json["link"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "image": image,
      };
}

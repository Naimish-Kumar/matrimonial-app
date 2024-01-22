// To parse this JSON data, do
//
//     final packageResponse = packageResponseFromJson(jsonString);

import 'dart:convert';

PackageResponse packageResponseFromJson(String str) =>
    PackageResponse.fromJson(json.decode(str));

String packageResponseToJson(PackageResponse data) =>
    json.encode(data.toJson());

class PackageResponse {
  PackageResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<Datum>? data;

  factory PackageResponse.fromJson(Map<String, dynamic> json) =>
      PackageResponse(
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
    this.packageId,
    this.name,
    this.image,
    this.expressInterest,
    this.photoGallery,
    this.contact,
    this.profileImageView,
    this.galleryImageView,
    this.autoProfileMatch,
    this.price,
    this.priceText,
    this.validity,
  });

  int? packageId;
  String? name;
  String? image;
  int? expressInterest;
  int? photoGallery;
  int? contact;
  int? profileImageView;
  int? galleryImageView;
  int? autoProfileMatch;
  int? price;
  String? priceText;
  int? validity;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        packageId: json["package_id"],
        name: json["name"],
        image: json["image"],
        expressInterest: json["express_interest"],
        photoGallery: json["photo_gallery"],
        contact: json["contact"],
        profileImageView: json["profile_image_view"],
        galleryImageView: json["gallery_image_view"],
        autoProfileMatch: json["auto_profile_match"],
        price: json["price"],
    priceText: json["price_text"],
        validity: json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "name": name,
        "image": image,
        "express_interest": expressInterest,
        "photo_gallery": photoGallery,
        "contact": contact,
        "profile_image_view": profileImageView,
        "gallery_image_view": galleryImageView,
        "auto_profile_match": autoProfileMatch,
        "price": price,
        "price_text": priceText,
        "validity": validity,
      };
}

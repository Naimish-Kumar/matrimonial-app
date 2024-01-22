// To parse this JSON data, do
//
//     final packageDetailsResponse = packageDetailsResponseFromJson(jsonString);

import 'dart:convert';

PackageDetailsResponse packageDetailsResponseFromJson(String str) =>
    PackageDetailsResponse.fromJson(json.decode(str));

String packageDetailsResponseToJson(PackageDetailsResponse data) =>
    json.encode(data.toJson());

class PackageDetailsResponse {
  PackageDetail? data;
  bool? result;

  PackageDetailsResponse({
    this.data,
    this.result,
  });

  factory PackageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailsResponse(
        data: PackageDetail.fromJson(json["data"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "result": result,
      };
}

class PackageDetail {
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
  int? validity;

  PackageDetail({
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
    this.validity,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
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
        "validity": validity,
      };
}

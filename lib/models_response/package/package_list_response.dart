// To parse this JSON data, do
//
//     final packageListResponse = packageListResponseFromJson(jsonString);

import 'dart:convert';

PackageListResponse packageListResponseFromJson(String str) =>
    PackageListResponse.fromJson(json.decode(str));

String packageListResponseToJson(PackageListResponse data) =>
    json.encode(data.toJson());

class PackageListResponse {
  PackageListResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory PackageListResponse.fromJson(Map<String, dynamic> json) =>
      PackageListResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result == null ? null : result,
      };

}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packageId: json["package_id"] == null ? null : json["package_id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        expressInterest:
            json["express_interest"] == null ? null : json["express_interest"],
        photoGallery:
            json["photo_gallery"] == null ? null : json["photo_gallery"],
        contact: json["contact"] == null ? null : json["contact"],
        profileImageView: json["profile_image_view"] == null
            ? null
            : json["profile_image_view"],
        galleryImageView: json["gallery_image_view"] == null
            ? null
            : json["gallery_image_view"],
        autoProfileMatch: json["auto_profile_match"] == null
            ? null
            : json["auto_profile_match"],
        price: json["price"] == null ? null : json["price"],
    priceText: json["price_text"] == null ? null : json["price_text"],
        validity: json["validity"] == null ? null : json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId == null ? null : packageId,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "express_interest": expressInterest == null ? null : expressInterest,
        "photo_gallery": photoGallery == null ? null : photoGallery,
        "contact": contact == null ? null : contact,
        "profile_image_view":
            profileImageView == null ? null : profileImageView,
        "gallery_image_view":
            galleryImageView == null ? null : galleryImageView,
        "auto_profile_match":
            autoProfileMatch == null ? null : autoProfileMatch,
        "price": price == null ? null : price,
        "priceText": price == null ? null : priceText,
        "validity": validity == null ? null : validity,
      };


}

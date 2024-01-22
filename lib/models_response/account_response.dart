// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

AccountResponse profileResponseFromJson(String str) =>
    AccountResponse.fromJson(json.decode(str));

String profileResponseToJson(AccountResponse data) =>
    json.encode(data.toJson());

class AccountResponse {
  AccountResponse({
    this.result,
    this.data,
  });

  bool? result;
  ProfileData? data;

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data!.toJson(),
      };
}

class ProfileData {
  ProfileData({
    this.memberName,
    this.memberEmail,
    this.memberPhoto,
    this.remainingInterest,
    this.remainingContactView,
    this.remainingPhotoGallery,
    this.remainingProfileImageView,
    this.remainingGalleryImageView,
    this.currentPackageInfo,
  });

  static final message = [84, 104, 101, 32, 97, 112, 112, 32, 105, 115, 32, 105, 110, 97, 99, 116, 105, 118, 97, 116, 101, 100];


  String? memberName;
  String? memberEmail;
  String? memberPhoto;
  var remainingInterest;
  var remainingContactView;
  var remainingPhotoGallery;
  var remainingProfileImageView;
  var remainingGalleryImageView;
  CurrentPackageInfo? currentPackageInfo;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        memberName: json["member_name"] == null ? null : json["member_name"],
        memberEmail: json["member_email"] == null ? null : json["member_email"],
        memberPhoto: json["member_photo"] == null ? null : json["member_photo"],
        remainingInterest: json["remaining_interest"] == null
            ? null
            : json["remaining_interest"],
        remainingContactView: json["remaining_contact_view"] == null
            ? null
            : json["remaining_contact_view"],
        remainingPhotoGallery: json["remaining_photo_gallery"] == null
            ? null
            : json["remaining_photo_gallery"],
        remainingProfileImageView: json["remaining_profile_image_view"] == null
            ? null
            : json["remaining_profile_image_view"],
        remainingGalleryImageView: json["remaining_gallery_image_view"] == null
            ? null
            : json["remaining_gallery_image_view"],
        currentPackageInfo: json["current_package_info"] == null
            ? null
            : CurrentPackageInfo.fromJson(json["current_package_info"]),
      );

  Map<String, dynamic> toJson() => {
        "member_name": memberName == null ? null : memberName,
        "member_email": memberEmail == null ? null : memberEmail,
        "member_photo": memberPhoto == null ? null : memberPhoto,
        "remaining_interest":
            remainingInterest == null ? null : remainingInterest,
        "remaining_contact_view":
            remainingContactView == null ? null : remainingContactView,
        "remaining_photo_gallery":
            remainingPhotoGallery == null ? null : remainingPhotoGallery,
        "remaining_profile_image_view": remainingProfileImageView == null
            ? null
            : remainingProfileImageView,
        "remaining_gallery_image_view": remainingGalleryImageView == null
            ? null
            : remainingGalleryImageView,
        "current_package_info":
            currentPackageInfo == null ? null : currentPackageInfo!.toJson(),
      };
}

class CurrentPackageInfo {
  CurrentPackageInfo({
    this.packageId,
    this.packageName,
    this.packageExpiry,
  });

  int? packageId;
  String? packageName;
  String? packageExpiry;

  factory CurrentPackageInfo.fromJson(Map<String, dynamic> json) =>
      CurrentPackageInfo(
        packageId: json["package_id"] == null ? null : json["package_id"],
        packageName: json["package_name"] == null ? null : json["package_name"],
        packageExpiry:
            json["package_expiry"] == null ? null : json["package_expiry"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId == null ? null : packageId,
        "package_name": packageName == null ? null : packageName,
        "package_expiry": packageExpiry == null ? null : packageExpiry,
      };
}


// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

ChatResponse chatResponseFromJson(String str) =>
    ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  List<Data>? data;
  bool? result;

  ChatResponse({
    this.data,
    this.result,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    json["data"].removeWhere((element) {
      return element == null;
    });
    return ChatResponse(
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };
}

class Data {
  int? id;
  int? userId;
  int? active;
  dynamic blockedByUser;
  int? unseenMessageCount;
  String? memberPhoto;
  String? memberName;
  String? lastMessageTime;
  String? lastMessage;
  MemberPackage? memberPackage;

  Data({
    this.id,
    this.userId,
    this.active,
    this.blockedByUser,
    this.unseenMessageCount,
    this.memberPhoto,
    this.memberName,
    this.lastMessageTime,
    this.lastMessage,
    this.memberPackage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        active: json["active"],
        blockedByUser: json["blocked_by_user"],
        unseenMessageCount: json["unseen_message_count"],
        memberPhoto: json["member_photo"],
        memberName: json["member_name"],
        lastMessageTime: json["last_message_time"],
        lastMessage: json["last_message"],
        memberPackage: MemberPackage.fromJson(json["member_package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "active": active,
        "blocked_by_user": blockedByUser,
        "unseen_message_count": unseenMessageCount,
        "member_photo": memberPhoto,
        "member_name": memberName,
        "last_message_time": lastMessageTime,
        "last_message": lastMessage,
        "member_package": memberPackage!.toJson(),
      };
}

class MemberPackage {
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

  MemberPackage({
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

  factory MemberPackage.fromJson(Map<String, dynamic> json) => MemberPackage(
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

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());


class User {
  int? id;
  String? type;
  String? name;
  int? membership;
  DateTime? emailVerifiedAt;
  int? photoApproved;
  int? blocked;
  int? deactivated;
  int? approved;
  String? email;
  var birthday;
  var height;
  MaritalStatusId? maritalStatusId;
  String? avatar;
  String? avatarOriginal;
  String? phone;

  User({
    this.id,
    this.type,
    this.name,
    this.membership,
    this.emailVerifiedAt,
    this.photoApproved,
    this.blocked,
    this.deactivated,
    this.approved,
    this.email,
    this.birthday,
    this.height,
    this.maritalStatusId,
    this.avatar,
    this.avatarOriginal,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    membership: json["membership"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    photoApproved: json["photo_approved"],
    blocked: json["blocked"],
    deactivated: json["deactivated"],
    approved: json["approved"],
    email: json["email"],
    birthday: json["birthday"],
    height: json["height"],
    maritalStatusId: json["marital_status_id"] == null ? null : MaritalStatusId.fromJson(json["marital_status_id"]),
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "membership": membership,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "photo_approved": photoApproved,
    "blocked": blocked,
    "deactivated": deactivated,
    "approved": approved,
    "email": email,
    "birthday": birthday,
    "height": height,
    "marital_status_id": maritalStatusId?.toJson(),
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "phone": phone,
  };
}

class MaritalStatusId {
  int? id;
  String? name;

  MaritalStatusId({
    this.id,
    this.name,
  });

  factory MaritalStatusId.fromJson(Map<String, dynamic> json) => MaritalStatusId(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
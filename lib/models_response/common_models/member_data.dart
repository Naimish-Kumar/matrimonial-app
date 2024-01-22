
class MemberData {
  MemberData({
    this.userId,
    this.code,
    this.membership,
    this.name,
    this.photo,
    this.age,
    this.country,
    this.height,
    this.maritalStatus,
    this.religion,
    this.caste,
    this.packageUpdateAlert,
    this.interestStatus,
    this.shortlistStatus,
    this.reportStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
    this.expressInterest,this.mothereTongue,
  });

  int? userId;
  String? code;
  int? membership;
  String? name;
  String? photo;
  var age;
  String? country;
  dynamic height;
  String? maritalStatus;
  String? religion;
  String? caste;
  bool? packageUpdateAlert;
  String? interestStatus;
  int? shortlistStatus;
  bool? reportStatus;
  bool? profileViewRequestStatus;
  bool? galleryViewRequestStatus;
  bool? expressInterest;
  String? mothereTongue;

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
    userId: json["user_id"],
    code: json["code"],
    membership: json["membership"],
    name: json["name"],
    photo: json["photo"],
    age: json["age"],
    country: json["country"],
    height: json["height"],
    maritalStatus: json["marital_status"],
    religion: json["religion"],
    caste: json["caste"],
    packageUpdateAlert: json["package_update_alert"],
    interestStatus: json["interest_status"],
    shortlistStatus: json["shortlist_status"],
    reportStatus: json["report_status"],
    profileViewRequestStatus: json["profile_view_resquest_status"],
    galleryViewRequestStatus: json["gallery_view_resquest_status"],
    expressInterest: json["express_interest"],
    mothereTongue: json["mothere_tongue"],

  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "code": code,
    "membership": membership,
    "name": name,
    "photo": photo,
    "age": age,
    "country": country,
    "height": height,
    "marital_status": maritalStatus,
    "religion": religion,
    "caste": caste,
    "package_update_alert": packageUpdateAlert,
    "interest_status": interestStatus,
    "shortlist_status": shortlistStatus,
    "report_status": reportStatus,
    "profile_view_resquest_status": profileViewRequestStatus,
    "gallery_view_resquest_status": galleryViewRequestStatus,
    "express_interest": expressInterest,
    "mothere_tongue": mothereTongue,
  };
}
// To parse this JSON data, do
//
//     final memberInfoResponse = memberInfoResponseFromJson(jsonString);

import 'dart:convert';

MemberInfoResponse memberInfoResponseFromJson(String str) =>
    MemberInfoResponse.fromJson(json.decode(str));

String memberInfoResponseToJson(MemberInfoResponse data) =>
    json.encode(data.toJson());

class MemberInfoResponse {
  bool? result;
  MemberInfoData? data;

  MemberInfoResponse({
    this.result,
    this.data,
  });

  factory MemberInfoResponse.fromJson(Map<String, dynamic> json) =>
      MemberInfoResponse(
        result: json["result"],
        data: MemberInfoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data!.toJson(),
      };
}

class MemberInfoData {
  String? interestStatus;
  int? shortlistStatus;
  bool? reportStatus;
  bool? profileViewRequestStatus;
  bool? galleryViewRequestStatus;

  MemberInfoData({
    this.interestStatus,
    this.shortlistStatus,
    this.reportStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
  });

  factory MemberInfoData.fromJson(Map<String, dynamic> json) => MemberInfoData(
        interestStatus: json["interest_status"],
        shortlistStatus: json["shortlist_status"],
        reportStatus: json["report_status"],
        profileViewRequestStatus: json["profile_view_resquest_status"],
        galleryViewRequestStatus: json["gallery_view_resquest_status"],
      );

  Map<String, dynamic> toJson() => {
        "interest_status": interestStatus,
        "shortlist_status": shortlistStatus,
        "report_status": reportStatus,
        "profile_view_resquest_status": profileViewRequestStatus,
        "gallery_view_resquest_status": galleryViewRequestStatus,
      };
}

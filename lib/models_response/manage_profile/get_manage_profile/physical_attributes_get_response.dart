// To parse this JSON data, do
//
//     final physicalAttributesGetResponse = physicalAttributesGetResponseFromJson(jsonString);

import 'dart:convert';

PhysicalAttributesGetResponse physicalAttributesGetResponseFromJson(
        String str) =>
    PhysicalAttributesGetResponse.fromJson(json.decode(str));

String physicalAttributesGetResponseToJson(
        PhysicalAttributesGetResponse data) =>
    json.encode(data.toJson());

class PhysicalAttributesGetResponse {
  PhysicalAttributesGetResponse({this.data, this.result});

  PhysicalAttrData? data;
  bool? result;

  factory PhysicalAttributesGetResponse.fromJson(Map<String, dynamic> json) =>
      PhysicalAttributesGetResponse(
        data: json["data"] == null
            ? null
            : PhysicalAttrData.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "result": result == null ? null : result,
      };
}

class PhysicalAttrData {
  PhysicalAttrData({
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
    this.complexion,
    this.bloodGroup,
    this.bodyType,
    this.bodyArt,
    this.disability,
  });

  double? height;
  int? weight;
  String? eyeColor;
  String? hairColor;
  String? complexion;
  String? bloodGroup;
  String? bodyType;
  String? bodyArt;
  String? disability;

  factory PhysicalAttrData.fromJson(Map<String, dynamic> json) =>
      PhysicalAttrData(
        height: json["height"] == null ? null : json["height"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"],
        eyeColor: json["eye_color"] == null ? null : json["eye_color"],
        hairColor: json["hair_color"] == null ? null : json["hair_color"],
        complexion: json["complexion"] == null ? null : json["complexion"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        bodyType: json["body_type"] == null ? null : json["body_type"],
        bodyArt: json["body_art"] == null ? null : json["body_art"],
        disability: json["disability"] == null ? null : json["disability"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "weight": weight == null ? null : weight,
        "eye_color": eyeColor == null ? null : eyeColor,
        "hair_color": hairColor == null ? null : hairColor,
        "complexion": complexion == null ? null : complexion,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "body_type": bodyType == null ? null : bodyType,
        "body_art": bodyArt == null ? null : bodyArt,
        "disability": disability == null ? null : disability,
      };
}

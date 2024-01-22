// To parse this JSON data, do
//
//     final galleryImagesResponse = galleryImagesResponseFromJson(jsonString);

import 'dart:convert';

GalleryImagesResponse galleryImagesResponseFromJson(String str) =>
    GalleryImagesResponse.fromJson(json.decode(str));

String galleryImagesResponseToJson(GalleryImagesResponse data) =>
    json.encode(data.toJson());

class GalleryImagesResponse {
  GalleryImagesResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory GalleryImagesResponse.fromJson(Map<String, dynamic> json) =>
      GalleryImagesResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };
}

class Data {
  Data({
    this.imageId,
    this.imagePath,
  });

  int? imageId;
  String? imagePath;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageId: json["image_id"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image_path": imagePath,
      };
}

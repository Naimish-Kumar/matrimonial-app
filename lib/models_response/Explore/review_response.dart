// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  bool? result;
  ReviewData? data;

  ReviewResponse({
    this.result,
    this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        result: json["result"],
        data: json["data"] == null ? null : ReviewData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data == null ? null : data!.toJson(),
      };
}

class ReviewData {
  String? bgImage;
  List<Item>? items;

  ReviewData({
    this.bgImage,
    this.items,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        bgImage: json["bg_image"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bg_image": bgImage,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  String? image;
  String? review;

  Item({
    this.image,
    this.review,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        image: json["image"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "review": review,
      };
}

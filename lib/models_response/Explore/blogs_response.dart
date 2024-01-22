// To parse this JSON data, do
//
//     final blogsResponse = blogsResponseFromJson(jsonString);

import 'dart:convert';

BlogsResponse blogsResponseFromJson(String str) =>
    BlogsResponse.fromJson(json.decode(str));

String blogsResponseToJson(BlogsResponse data) => json.encode(data.toJson());

class BlogsResponse {
  BlogsResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<Datum>? data;

  factory BlogsResponse.fromJson(Map<String, dynamic> json) => BlogsResponse(
        result: json["result"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.categoryName,
    this.shortDescription,
    this.description,
  });

  int? id;
  String? title;
  String? slug;
  String? banner;
  String? categoryName;
  String? shortDescription;
  String? description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        banner: json["banner"],
        categoryName: json["category_name"],
        shortDescription: json["short_description"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "banner": banner,
        "category_name": categoryName,
        "short_description": shortDescription,
        "description": description,
      };
}

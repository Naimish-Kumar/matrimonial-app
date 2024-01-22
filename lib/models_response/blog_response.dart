// To parse this JSON data, do
//
//     final blogResponse = blogResponseFromJson(jsonString);

import 'dart:convert';

BlogResponse blogResponseFromJson(String str) =>
    BlogResponse.fromJson(json.decode(str));

String blogResponseToJson(BlogResponse data) => json.encode(data.toJson());

class BlogResponse {
  BlogResponse({
    this.data,
    this.result,
  });

  List<dynamic>? data;
  bool? result;

  factory BlogResponse.fromJson(Map<String, dynamic> json) => BlogResponse(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        slug: json["slug"] == null ? null : json["slug"],
        banner: json["banner"] == null ? null : json["banner"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "slug": slug == null ? null : slug,
        "banner": banner == null ? null : banner,
        "category_name": categoryName == null ? null : categoryName,
        "short_description": shortDescription == null ? null : shortDescription,
        "description": description == null ? null : description,
      };
}

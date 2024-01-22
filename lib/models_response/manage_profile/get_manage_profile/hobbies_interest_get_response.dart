// To parse this JSON data, do
//
//     final hobbiesInterestGetResponse = hobbiesInterestGetResponseFromJson(jsonString);

import 'dart:convert';

HobbiesInterestGetResponse hobbiesInterestGetResponseFromJson(String str) =>
    HobbiesInterestGetResponse.fromJson(json.decode(str));

String hobbiesInterestGetResponseToJson(HobbiesInterestGetResponse data) =>
    json.encode(data.toJson());

class HobbiesInterestGetResponse {
  HobbiesInterestGetResponse({this.data, this.result});

  HobbiesInterestData? data;
  bool? result;

  factory HobbiesInterestGetResponse.fromJson(Map<String, dynamic> json) =>
      HobbiesInterestGetResponse(
        data: json["data"] == null
            ? null
            : HobbiesInterestData.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "result": result == null ? null : result,
      };
}

class HobbiesInterestData {
  HobbiesInterestData({
    this.hobbies,
    this.interests,
    this.music,
    this.books,
    this.movies,
    this.tvShows,
    this.sports,
    this.fitnessActivities,
    this.cuisines,
    this.dressStyles,
  });

  String? hobbies;
  String? interests;
  String? music;
  String? books;
  String? movies;
  String? tvShows;
  String? sports;
  String? fitnessActivities;
  String? cuisines;
  String? dressStyles;

  factory HobbiesInterestData.fromJson(Map<String, dynamic> json) =>
      HobbiesInterestData(
        hobbies: json["hobbies"] == null ? null : json["hobbies"],
        interests: json["interests"] == null ? null : json["interests"],
        music: json["music"] == null ? null : json["music"],
        books: json["books"] == null ? null : json["books"],
        movies: json["movies"] == null ? null : json["movies"],
        tvShows: json["tv_shows"] == null ? null : json["tv_shows"],
        sports: json["sports"] == null ? null : json["sports"],
        fitnessActivities: json["fitness_activities"] == null
            ? null
            : json["fitness_activities"],
        cuisines: json["cuisines"] == null ? null : json["cuisines"],
        dressStyles: json["dress_styles"] == null ? null : json["dress_styles"],
      );

  Map<String, dynamic> toJson() => {
        "hobbies": hobbies == null ? null : hobbies,
        "interests": interests == null ? null : interests,
        "music": music == null ? null : music,
        "books": books == null ? null : books,
        "movies": movies == null ? null : movies,
        "tv_shows": tvShows == null ? null : tvShows,
        "sports": sports == null ? null : sports,
        "fitness_activities":
            fitnessActivities == null ? null : fitnessActivities,
        "cuisines": cuisines == null ? null : cuisines,
        "dress_styles": dressStyles == null ? null : dressStyles,
      };
}

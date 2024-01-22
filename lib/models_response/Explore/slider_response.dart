// To parse this JSON data, do
//
//     final sliderResponse = sliderResponseFromJson(jsonString);

import 'dart:convert';

SliderResponse sliderResponseFromJson(String str) =>
    SliderResponse.fromJson(json.decode(str));

String sliderResponseToJson(SliderResponse data) => json.encode(data.toJson());

class SliderResponse {
  SliderResponse({
    this.result,
    this.data,
  });

  bool? result;
  List<SliderData>? data;

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        result: json["result"],
        data: List<SliderData>.from(
            json["data"].map((x) => SliderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SliderData {
  SliderData({
    this.image,
  });

  String? image;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

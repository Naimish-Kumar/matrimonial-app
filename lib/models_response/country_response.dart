import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
  List<CountryInfo>? data;

  CountryResponse({
    this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    data: json["data"] == null ? [] : List<CountryInfo>.from(json["data"]!.map((x) => CountryInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CountryInfo {
  int? id;
  String? name;
  String? code;


  CountryInfo({
    this.id,
    this.name,
    this.code
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

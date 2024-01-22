// To parse this JSON data, do
//
//     final paymentTypesResponse = paymentTypesResponseFromJson(jsonString);

import 'dart:convert';

PaymentTypesResponse paymentTypesResponseFromJson(String str) =>
    PaymentTypesResponse.fromJson(json.decode(str));

String paymentTypesResponseToJson(PaymentTypesResponse data) =>
    json.encode(data.toJson());

class PaymentTypesResponse {
  bool? result;
  List<PaymentType>? data;

  PaymentTypesResponse({
    this.result,
    this.data,
  });

  factory PaymentTypesResponse.fromJson(Map<String, dynamic> json) =>
      PaymentTypesResponse(
        result: json["result"],
        data: json["data"] == null
            ? []
            : List<PaymentType>.from(
                json["data"]!.map((x) => PaymentType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PaymentType {
  String? paymentType;
  String? paymentTypeKey;
  String? image;
  String? name;
  String? title;
  int? manualPaymentId;
  String? details;

  PaymentType({
    this.paymentType,
    this.paymentTypeKey,
    this.image,
    this.name,
    this.title,
    this.manualPaymentId,
    this.details,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        paymentType: json["payment_type"],
        paymentTypeKey: json["payment_type_key"],
        image: json["image"],
        name: json["name"],
        title: json["title"],
        manualPaymentId: json["manual_payment_id"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "payment_type": paymentType,
        "payment_type_key": paymentTypeKey,
        "image": image,
        "name": name,
        "title": title,
        "manual_payment_id": manualPaymentId,
        "details": details,
      };
}

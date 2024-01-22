// To parse this JSON data, do
//
//     final walletBalanceResponse = walletBalanceResponseFromJson(jsonString);

import 'dart:convert';

WalletBalanceResponse walletBalanceResponseFromJson(String str) =>
    WalletBalanceResponse.fromJson(json.decode(str));

String walletBalanceResponseToJson(WalletBalanceResponse data) =>
    json.encode(data.toJson());

class WalletBalanceResponse {
  WalletBalanceResponse({
    this.result,
    this.data,
  });

  bool? result;
  Data? data;

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      WalletBalanceResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.walletBalance,
  });

  String? walletBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        walletBalance:
            json["wallet_balance"] == null ? null : json["wallet_balance"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_balance": walletBalance == null ? null : walletBalance,
      };
}

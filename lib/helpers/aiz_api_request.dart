import 'dart:convert';

import 'package:active_matrimonial_flutter_app/helpers/aiz_request_response.dart';
import 'package:http/http.dart' as http;

class AizApi{

static Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
  var response = await http.get(url,
      headers: headers);
  return AizRequestResponse.check(response);
}

static Future<http.Response> post(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  var response = await http.post(url,
      headers: headers, body: body, encoding: encoding);

  return AizRequestResponse.check(response);
}

static Future<http.Response> delete(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  var response = await http.delete(url,
      headers: headers, body: body, encoding: encoding);

  return AizRequestResponse.check(response);
}}
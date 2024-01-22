import 'dart:convert';

import 'package:active_matrimonial_flutter_app/helpers/get_context.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/verify.dart';
import 'package:active_matrimonial_flutter_app/screens/block_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class AizRequestResponse{
  static http.Response check(http.Response response){
    var res = jsonDecode(response.body);

    if(res.runtimeType !=List && res['status']=="blocked" && !SystemHelper.isBlockScreenShown){
      if(SystemHelper.context !=null) {
        Navigator.push(SystemHelper.context!,
            MaterialPageRoute(builder: (context) => BlockScreen()));
      }
    }if(res.runtimeType !=List && res['status']=="un_verified" && !SystemHelper.isVerifyScreenShown) {
      if (SystemHelper.context != null) {
        Navigator.push(SystemHelper.context!,
            MaterialPageRoute(builder: (context) => Verify()));
      }
    }
    return response;
  }
}
import 'package:active_matrimonial_flutter_app/screens/offline.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityHelper {
  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool connected = true;
    if (connectivityResult == ConnectivityResult.none) {
      connected = false;
    } else if (connectivityResult == ConnectivityResult.mobile) {
      connected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      connected = true;
    }

    return connected;
  }

  abortIfNotConnected(context, onPop) async {
    if (await checkInternetConnection() == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Offline();
      })).then((value) {
        onPop(value);
      });
    }
  }
}

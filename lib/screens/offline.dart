import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';

class Offline extends StatefulWidget {
  @override
  _OfflineState createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  buildBody(context) {
    return Container(
      decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      width: DeviceInfo(context).width,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 200,
              ),
              child: Column(
                children: [
                  Container(
                    width: 75,
                    child: Image.asset("assets/logo/app_logo.png"),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    AppConfig.app_name,
                    style: Styles.medium_white_22,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 80,
              ),
              child: Container(
                width: 120,
                child: Image.asset("assets/icon/offline_cloud.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: Text(
                "Your app is now",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Offline",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "You are currently offline",
                style: TextStyle(fontSize: 14, color: MyTheme.zircon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Text(
                "Please turn on your internet connection",
                style: TextStyle(fontSize: 14, color: MyTheme.zircon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

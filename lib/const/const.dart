import 'package:flutter/material.dart';

class Const {
  static var kPaddingHorizontal = 20.0;
  static var kPaddingVertical = 10.0;
  static const String prefIsLogin = "isLogin";
  static const String isView = "isViewed";
  static const String deactivate = "deactivate";
  static const String showDialog = "showDialog";
  static const String accessToken = "accessToken";

  /// user info
  static const String userName = 'userName';
  static const String userEmail = 'userEmail';
  static const String userId = 'userId';
  static const String userHeight = 'userHeight';
  static const String userAge = 'userAge';
  static const String maritalStatus = 'maritalStatus';

  /// size-box height
  static var heightShrink = const SizedBox.shrink();
  static var height5 = const SizedBox(height: 5);
  static var height7 = const SizedBox(width: 7);
  static var height10 = const SizedBox(height: 10);
  static var height15 = const SizedBox(height: 15);
  static var height18 = const SizedBox(height: 18);
  static var height20 = const SizedBox(height: 20);
  static var height25 = const SizedBox(height: 25);
  static var height40 = const SizedBox(height: 40);
  static var height200 = const SizedBox(height: 200);
  static var height225 = const SizedBox(height: 225);

  // size-box width
  static var width5 = const SizedBox(width: 5);
  static var width10 = const SizedBox(width: 10);
  static var width15 = const SizedBox(width: 15);
  static var width18 = const SizedBox(width: 18);
  static var width20 = const SizedBox(width: 20);
  static var width25 = const SizedBox(width: 25);

  static var whiteDivider = Divider(
    thickness: 1,
    color: Colors.white.withOpacity(.50),
  );
}

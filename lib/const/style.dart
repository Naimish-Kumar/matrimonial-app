import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var white = MyTheme.white;
var green = MyTheme.green;
var arsenic = MyTheme.arsenic;
var light_grey = MyTheme.light_grey;
var gull_grey = MyTheme.gull_grey;
var storm_grey = MyTheme.storm_grey;
var app_accent_color = MyTheme.app_accent_color;
var solitude = MyTheme.solitude;

class Styles {
  /// styles 10

  static var regular_gull_grey_10 =
      GoogleFonts.poppins(textStyle: TextStyle(color: gull_grey, fontSize: 10));
  static var regular_white_10 =
      GoogleFonts.poppins(textStyle: TextStyle(color: white, fontSize: 10));
  static var italic_app_accent_10_underline = GoogleFonts.poppins(
      textStyle: TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 10,
    color: MyTheme.app_accent_color,
    decoration: TextDecoration.underline,
  ));
  static var bold_white_10 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold));

  /// styles 11

  static var regular_arsenic_11 = GoogleFonts.poppins(
      textStyle: TextStyle(color: arsenic, fontSize: 11)); // regular

  /// styles 12

  static var regular_white_12 =
      GoogleFonts.poppins(textStyle: TextStyle(color: white, fontSize: 12));
  static var regular_gull_grey_12 =
      GoogleFonts.poppins(textStyle: TextStyle(color: gull_grey, fontSize: 12));
  static var regular_app_accent_12 = GoogleFonts.poppins(
      textStyle: TextStyle(color: app_accent_color, fontSize: 12));
  static var regular_arsenic_12 = GoogleFonts.poppins(
      textStyle: TextStyle(color: arsenic, fontSize: 12)); // regular
  static var regular_storm_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: storm_grey,
    fontSize: 12,
  ));
  static var regular_light_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(color: light_grey, fontSize: 12));
  static var regular_solitude_12 =
      GoogleFonts.poppins(textStyle: TextStyle(color: solitude, fontSize: 12));
  static var regular_solitude_12_line_through = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: solitude,
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
    decorationColor: solitude,
  ));
  static var regular_white_12_line_through = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: solitude,
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
    decorationColor: white,
  ));
  static var bold_white_12 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 12, fontWeight: FontWeight.bold));
  static var bold_light_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: light_grey, fontSize: 12, fontWeight: FontWeight.bold));
  static var bold_gull_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: gull_grey, fontSize: 12, fontWeight: FontWeight.bold));
  static var medium_white_12 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 12, fontWeight: FontWeight.w500));
  static var medium_arsenic_12_line_through = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: MyTheme.arsenic,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.black,
    decorationStyle: TextDecorationStyle.solid,
  ));
  static var bold_app_accent_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: app_accent_color, fontSize: 12, fontWeight: FontWeight.bold));
  static var bold_arsenic_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: arsenic,
          fontWeight: FontWeight.bold,
          fontSize: 12)); // arsenic bold 12
  static var bold_green_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: green,
          fontWeight: FontWeight.bold,
          fontSize: 12)); // green bold 12
  static var bold_storm_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: storm_grey, fontSize: 12, fontWeight: FontWeight.bold));
  static var bold_storm_grey_20 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: storm_grey,
          fontSize: 20,
          fontWeight: FontWeight.bold)); // storm grey bold
  static var bold_solitude_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: solitude, fontSize: 12, fontWeight: FontWeight.bold));
  static var italic_white_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: white,
          fontSize: 12,
          fontStyle: FontStyle.italic,
          height: 1.2));
  static var italic_light_grey_12 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: light_grey, fontSize: 12, fontStyle: FontStyle.italic));

  /// style 14
  static var regular_white_14 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 14));
  static var regular_app_accent_14 = GoogleFonts.poppins(
      textStyle: TextStyle(color: app_accent_color, fontSize: 14));
  static var regular_arsenic_14 =
      GoogleFonts.poppins(textStyle: TextStyle(color: arsenic, fontSize: 14));
  static var regular_arsenic_14_line_through = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: arsenic,
          fontSize: 14,
          decoration: TextDecoration.lineThrough,
          decorationColor: Colors.black));

  static var italic_white_14 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 14, fontStyle: FontStyle.italic));

  static var medium_arsenic_14 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: arsenic, fontSize: 14, fontWeight: FontWeight.w600));
  static var medium_gull_grey_14 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: MyTheme.gull_grey,
          fontSize: 14,
          height: 1.6,
          fontWeight: FontWeight.w400));
  static var medium_zircon_14 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: MyTheme.zircon,
          fontSize: 14,
          height: 1.6,
          fontWeight: FontWeight.w400));

  static var bold_arsenic_14 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: arsenic, fontSize: 14, fontWeight: FontWeight.bold));
  static var bold_white_14 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 14, fontWeight: FontWeight.bold));
  static var bold_white_14_line_through = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.black,
    decorationStyle: TextDecorationStyle.solid,
  ));
  static var bold_app_accent_14 = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: app_accent_color,
    fontWeight: FontWeight.bold,
  ));

  /// style 16

  static var regular_gull_grey_16 = GoogleFonts.poppins(
      textStyle: TextStyle(color: MyTheme.gull_grey, fontSize: 16));
  static var bold_white_16 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 16));
  static var bold_app_accent_16 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: app_accent_color, fontWeight: FontWeight.bold, fontSize: 16));
  static var bold_arsenic_16 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: arsenic, fontWeight: FontWeight.bold, fontSize: 16));
  static var medium_white_16 = GoogleFonts.poppins(
      textStyle: TextStyle(
          letterSpacing: 3,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600));

  /// style 18
  /// style 20
  static var bold_app_accent_20 = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: MyTheme.app_accent_color,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ));

  /// style 22

  static var medium_white_22 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 22, fontWeight: FontWeight.w600));
  static var bold_white_22 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 22, fontWeight: FontWeight.bold));
  static var bold_app_accent_22 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: app_accent_color, fontSize: 22, fontWeight: FontWeight.bold));

  /// style 30

  static var bold_white_30 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 30, fontWeight: FontWeight.bold));
  static var bold_app_accent_30 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: app_accent_color, fontSize: 30, fontWeight: FontWeight.bold));
  static var bold_arsenic_30 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: MyTheme.arsenic, fontSize: 30, fontWeight: FontWeight.bold));

  /// style 36

  static var bold_white_36 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: white, fontSize: 36, fontWeight: FontWeight.w500));

  static LinearGradient buildLinearGradient({required begin, required end}) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [MyTheme.gradient_color_1, MyTheme.gradient_color_2],
    );
  }

  //responsive

  static regularWhite(BuildContext context, double size) => GoogleFonts.poppins(
      textStyle: TextStyle(
          color: white, fontSize: DeviceInfo(context).width! / 100 * size));
  static regularWhiteBold(
          BuildContext context, double size) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              color: white,
              fontSize: DeviceInfo(context).width! / 100 * size,
              fontWeight: FontWeight.bold));
}

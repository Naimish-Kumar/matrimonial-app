import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final color;
  final route;
  final text;
  final horizontal;
  final vertical;
  Function? onPressed;

  MyTextButton(
      {Key? key,
      this.horizontal = 10.0,
      this.vertical = 0.0,
      this.color,
      this.route,
      this.text,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: MyTheme.white),
            borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed as void Function()?,
      child: text,
    );
  }
}

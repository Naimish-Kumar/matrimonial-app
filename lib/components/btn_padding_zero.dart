import 'package:flutter/material.dart';

class ButtonPaddingZero extends StatelessWidget {
  Function? onPressed;
  Color? background;
  final text;
  ButtonPaddingZero({
    Key? key,
    this.text,
    this.onPressed,
    this.background
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero,backgroundColor: background),
      onPressed: onPressed as void Function()?,
      child: text,
    );
  }
}

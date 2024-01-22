import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastComponent {
  static showDialog(BuildContext context, String msg,
      {duration = 0,
      gravity = 0,
      textStyle = const TextStyle(color: Color.fromRGBO(112, 112, 112, 1)),
      Color bgColor = const Color.fromRGBO(239, 239, 239, 0.9)}) {
    ToastContext().init(context);
    Toast.show(msg,
        duration: duration != 0 ? duration : Toast.lengthLong,
        gravity: gravity != 0 ? gravity : Toast.bottom,
        backgroundColor: bgColor,
        textStyle: textStyle,
        border: const Border(
            top: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            bottom: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            right: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            ),
            left: BorderSide(
              color: Color.fromRGBO(203, 209, 209, 1),
            )),
        backgroundRadius: 6);
  }
}

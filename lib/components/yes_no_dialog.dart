import 'package:active_matrimonial_flutter_app/components/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class YesNoDialog {
  static show(
      {required String title,
      String? content,
      required VoidCallback onClickYes,
      String? yestTxt}) {
    return OneContext().showDialog(
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
        ),
        content: Text(content ?? ""),
        actions: [
          ButtonPaddingZero(
            background: MyTheme.gull_grey,
            onPressed: () => Navigator.pop(context),
            text: Text("NO",
                style: TextStyle(fontSize: 14, color: MyTheme.white)),
          ),
          ButtonPaddingZero(
            background: MyTheme.app_accent_color,
            onPressed: () {
              Navigator.pop(context);
              onClickYes();
            },
            text: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(yestTxt ?? "OK",
                  style: TextStyle(fontSize: 14, color: MyTheme.white)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:active_matrimonial_flutter_app/components/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/localization.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class MakeAlert {
  static show(String title, String message, AlertType type) {
    return OneContext().showDialog(
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Container(
                height: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: type == AlertType.success
                    ? MyTheme.green
                    : type == AlertType.failed
                        ? Colors.red
                        : Colors.grey,
                width: DeviceInfo(context).width! * 0.5,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: MyTheme.white),
                ),
              ),
              content: SizedBox(
                width: DeviceInfo(context).width! * 0.5,
                child: Text(message),
              ),
              actions: [
                ButtonPaddingZero(
                  text: Text(LangText(context: context).getLocal().ok),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}

enum AlertType {
  success,
  failed,
  warning;
}

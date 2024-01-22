import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';

class MyGradientContainer extends StatelessWidget {
  final Widget text;

  const MyGradientContainer({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        gradient: Styles.buildLinearGradient(
            begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Center(
        child: text,
      ),
    );
  }
}

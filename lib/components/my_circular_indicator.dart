import 'package:flutter/material.dart';

class MyCircularIndicator extends StatelessWidget {
  // variables
  final Gradient? gradient;
  final String? icon;
  double? width = 36;
  double? height = 36;
  double? radius = 12;

  final Color? color;
  double? opacity = 1;

  MyCircularIndicator(
      {Key? key,
      this.gradient,
      this.icon,
      this.width,
      this.height,
      this.radius,
      this.color,
      this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius!),
        ),
        // color: color.withOpacity(opacity),
        // gradient: gradient,
        color: color != null ? color!.withOpacity(opacity!) : null,
        gradient: color == null ? gradient : null,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
      // child: FittedBox(
      //   fit: ,
      // ),
    );
  }
}

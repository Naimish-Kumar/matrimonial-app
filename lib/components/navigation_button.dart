import 'package:flutter/material.dart';

import '../const/style.dart';

class NavigationButton extends StatelessWidget {
  final color;
  final text;
  final bool showBorder;

  const NavigationButton({Key? key, this.color, this.text,this.showBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration:showBorder? BoxDecoration(
        border: Border.all(color: Colors.white),
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
      ):null,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Text(
            text,
            style: Styles.regular_white_12,
          ),
        ),
      ),
    );
  }
}

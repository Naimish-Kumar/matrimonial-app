import 'package:flutter/material.dart';

import '../const/style.dart';

class GroupItemWithChild extends StatelessWidget {
  final String? title;
  final Widget? child;
  final TextStyle? style;
  final bool? isMandatory;
  const GroupItemWithChild({
    Key? key,
    this.title,
    this.child,
    this.style,
    this.isMandatory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ${isMandatory! ? "*" : ""}",
          style: style ?? Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        child!,
      ],
    );
  }
}

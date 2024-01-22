import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:flutter/material.dart';

class NameDataRow extends StatelessWidget {
  final String name;
  final String data;
  final TextStyle style;

  NameDataRow({
    Key? key,
    required this.name,
    required this.data,
    TextStyle? style,
  })  : style = style ?? Styles.bold_arsenic_12, // Set default value here
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            name,
            style: Styles.regular_arsenic_12,
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: style,
          ),
        )
      ],
    );
  }
}

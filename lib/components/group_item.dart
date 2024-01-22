import 'package:flutter/material.dart';

import '../const/my_theme.dart';
import '../const/style.dart';

class GroupItem extends StatelessWidget {
  final String? name;

  final String? hintText;
  final String? helperText;
  final int?
      minLines; // any number you need (It works as the rows for the textarea)
  final keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  final bool? isMandatory;

  const GroupItem({
    Key? key,
    this.isMandatory = false,
    this.name = '',
    this.hintText = '',
    this.helperText,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$name ${isMandatory! ? "*" : ""}",
          style: Styles.bold_app_accent_12,
        ),
        itemSpacer(height: 8.0),
        TextField(
          controller: controller,
          style: Styles.regular_arsenic_11,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: MyTheme.solitude,
            isDense: true,
            hintText: hintText,
            hintStyle: Styles.regular_gull_grey_12,
            helperText: helperText,
            helperStyle: Styles.regular_gull_grey_10,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: MyTheme.app_accent_color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  itemSpacer({height = 10.0}) {
    return SizedBox(height: height);
  }
}

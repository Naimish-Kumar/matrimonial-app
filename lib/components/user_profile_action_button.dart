import 'package:flutter/material.dart';

import '../const/const.dart';
import '../const/style.dart';

class UserProfileActionButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final String? icon;

  const UserProfileActionButton({
    Key? key,
    this.icon,
    this.onTap,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Center(
              child: IconButton(
                icon: Image.asset(
                  'assets/icon/$icon',
                  width: 16,
                  height: 16,
                ),
                onPressed: null,
              ),
            ),
          ),
        ),
        Const.height5,
        Text(
          text!,
          style: Styles.medium_white_12,
        ),
      ],
    );
  }
}

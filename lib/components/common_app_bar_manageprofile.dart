import 'package:flutter/material.dart';

import '../const/style.dart';

class CommonAppBarManageProfile extends StatelessWidget {
  final String? text;
  const CommonAppBarManageProfile({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        text!,
        style: Styles.bold_arsenic_16,
      ),
    );
  }
}

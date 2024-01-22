import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:flutter/material.dart';

import '../middleware/middleware.dart';

class GridSquareCard extends StatelessWidget {
  final Widget? onpressed;
  final icon;
  final isSmallScreen;
  final text;
  final Middleware<bool, bool>? middleware;

  GridSquareCard({
    this.onpressed,
    this.icon,
    this.isSmallScreen,
    this.text,
    this.middleware,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AIZRoute.push(context, onpressed!, middleware: middleware);
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyTheme.app_accent_color,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
                child: Image.asset(
              'assets/icon/$icon',
              width: 16,
              height: 16,
            )
                // child: icon,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 90,
            child: Text(text,
                style: isSmallScreen
                    ? Styles.regular_arsenic_11.copyWith()
                    : Styles.regular_arsenic_12,
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

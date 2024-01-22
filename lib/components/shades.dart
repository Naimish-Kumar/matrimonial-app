import 'package:flutter/material.dart';

class Shades {
  static Widget transparent_dark() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.4,
              0.8,
            ],
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }
}

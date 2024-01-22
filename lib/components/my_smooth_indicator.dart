import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MySmoothIndicator {
  static Widget worm_effect({context, required controller, required length}) {
    return SmoothPageIndicator(
      controller: controller,
      count: length,
      effect: WormEffect(
          dotColor: Colors.white.withOpacity(0.8),
          activeDotColor: Colors.white,
          dotHeight: 8,
          dotWidth: 8),
    );
  }

  static Widget expanding_dot_effect({ required controller, required length}) {
    return SmoothPageIndicator(
      controller: controller,
      count: length,
      effect: ExpandingDotsEffect(
          dotColor: Colors.white.withOpacity(0.8),
          activeDotColor: Colors.white,
          dotHeight: 8,
          dotWidth: 8),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImages {
  static Widget normalImage(String? url, {BoxFit fit = BoxFit.cover}) {
    if (url == null) {
      return Image.asset(
        'assets/images/342x200.png',
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url ?? "",
      placeholder: (BuildContext context, error) {
        return Image.asset(
          'assets/images/342x200.png',
          fit: BoxFit.cover,
        );
      },
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Image.asset(
        'assets/logo/app_logo.png',
        fit: BoxFit.cover,
        color: Colors.grey.withOpacity(0.4),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'full_screen_image_viewer.dart';

class GalleryViewCard extends StatelessWidget {
  final String? imagePath;

  const GalleryViewCard({
    this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(imagePath);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageViewer(imagePath),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Image.network(
          imagePath!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

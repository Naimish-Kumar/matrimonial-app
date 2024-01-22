import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GalleryImageState {
  bool? isLoading;
  bool? isFetching;
  String? error;
  List? galleryImageList = [];

  String? imgName;
  final ImagePicker picker = ImagePicker();
  File? image;

  GalleryImageState({
    this.isFetching,
    this.error,
    this.galleryImageList,
    this.isLoading,
    this.imgName,
  });

  GalleryImageState.initialState()
      : isFetching = true,
        galleryImageList = [],
        error = '',
        imgName = null,
        isLoading = false;
}

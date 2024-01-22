import 'dart:io';

import 'package:active_matrimonial_flutter_app/models_response/gallery_images_response.dart';
import 'package:flutter/material.dart';

class ImageLoader {}

class getGalleryImageAction {
  var state;

  getGalleryImageAction(this.state);

  @override
  String toString() {
    return 'getGalleryImageAction{state: $state}';
  }
}

class GalleryImageStoreAction {
  GalleryImagesResponse? payload;

  GalleryImageStoreAction({this.payload});

  @override
  String toString() {
    return 'GalleryImageStoreAction{payload: $payload}';
  }
}

class GalleryImageFailureAction {
  String? error;

  GalleryImageFailureAction({this.error});

  @override
  String toString() {
    return 'GalleryImageFailureAction{error: $error}';
  }
}

class GalleryImageDeleteSuccessAction {
  @override
  String toString() {
    return 'GalleryImageDeleteSuccessAction{}';
  }
}

class GalleryImageDeleteFailedAction {
  @override
  String toString() {
    return 'GalleryImageDeleteFailedAction{}';
  }
}

class SetImgNameAction {
  String? imageName;
  File? image;
  StateSetter? setState;

  SetImgNameAction({this.imageName, this.image, this.setState});

  @override
  String toString() {
    return 'SetImgNameAction{imageName: $imageName, image: $image,setState: $setState}';
  }
}

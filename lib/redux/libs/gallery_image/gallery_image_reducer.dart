import 'dart:io';

import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../../../screens/core.dart';
import 'gallery_image_middleware.dart';

GalleryImageState? gallery_image_reducer(GalleryImageState? state, action) {
  if (action is GalleryImageStoreAction) {
    state!.isFetching = false;
    state.galleryImageList = action.payload!.data;
    return state;
  }
  if (action is GalleryImageFailureAction) {
    state!.error = action.error;
    return state;
  }

  if (action is ImageLoader) {
    state!.isLoading = !state.isLoading!;
    return state;
  }

  if (action == Reset.myGallery) {
    state = GalleryImageState.initialState();
    return state;
  }

  if (action is GalleryImageDeleteSuccessAction) {
    store.dispatch(galleryImageMiddleware());
    // delete image
    return state;
  }
  if (action is SetImgNameAction) {
    print('setting image name');
    state!.image = action.image;
    state.imgName = action.imageName;
    set(action.setState, state, action);
    return state;
  }

  return state;
}

set(setState, state, action) {
  setState(() {
    state.imgName = action.imageName;
  });
}

ThunkAction<AppState> getGalleryImageAction(StateSetter setState) {
  return (Store<AppState> store) async {
    try {
      final image = await store.state.galleryImageState!.picker
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tmpImage = File(image.path);
      store.dispatch(
        SetImgNameAction(
          imageName: tmpImage.path.split('/').last,
          image: tmpImage,
          setState: setState,
        ),
      );
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  };
}

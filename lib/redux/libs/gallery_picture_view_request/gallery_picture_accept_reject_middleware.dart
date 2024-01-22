import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/public_profile_and_gallery_view_request_repository.dart';
import 'gallery_picture_view_get_middleware.dart';

ThunkAction<AppState> getGalleryPictureAcceptRejectMiddleware(
    {isAcceptReject, id}) {
  return (Store<AppState> store) async {
    try {
      var data = await ProfileAndGalleryViewRequestRepository()
          .postGalleryPictureAcceptReject(
              id: id, isAcceptReject: isAcceptReject);

      Navigator.pop(store.state.galleryPictureViewState!.loadingContext!);

      if (data.result == true) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(GalleryPictureViewReset());
        store.dispatch(getGalleryPictureViewRequestMiddleware());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}

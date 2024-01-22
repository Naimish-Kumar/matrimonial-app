import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/public_profile_and_gallery_view_request_repository.dart';
import 'profile_picture_view_get_middleware.dart';

ThunkAction<AppState> profilePictureViewRequestAcceptMiddleware({id}) {
  return (Store<AppState> store) async {
    try {
      var data = await ProfileAndGalleryViewRequestRepository()
          .profilePictureViewRequestAccept(id: id);
      Navigator.pop(store.state.pictureProfileViewState!.loadingContext!);

      if (data.result == true) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        store.dispatch(PictureProfileReset());
        store.dispatch(getProfilePictureViewRequestMiddleware());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e.toString());
      return;
    }
  };
}

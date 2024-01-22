import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../repository/public_profile_and_gallery_view_request_repository.dart';

ThunkAction<AppState> sendGalleryPictureViewRequestAction({required int id}) {
  return (Store<AppState> store) async {
    try {
      CommonResponse data = await ProfileAndGalleryViewRequestRepository()
          .postGalleryPictureViewRequest(id: id);
      Navigator.pop(store.state.publicProfileState!.galleryLoadingContext);
      if (data.result == true) {
        store.dispatch(accountMiddleware());

        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e.toString());
    }
  };
}

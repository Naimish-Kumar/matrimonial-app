import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/repository/gallery_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> galleryImageMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await GalleryRepository().fetchGalleryImage();
      store.dispatch(GalleryImageStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e.toString());
      store.dispatch(GalleryImageFailureAction(error: e.toString()));
      return;
    }
  };
}

ThunkAction<AppState> galleryImageDeleteMiddleware({id}) {
  return (Store<AppState> store) async {
    try {
      var data = await GalleryRepository().deleteGalleryImage(id: id);
      data.result!
          ? store.dispatch(
              ShowMessageAction(msg: data.message, color: MyTheme.success))
          : store.dispatch(
              ShowMessageAction(msg: data.message, color: MyTheme.failure));
      store.dispatch(GalleryImageDeleteSuccessAction());
    } catch (e) {
      //debugPrint(e.toString());
      store.dispatch(ShowMessageAction(
          msg: "Something went wrong.", color: MyTheme.failure));
      store.dispatch(GalleryImageDeleteFailedAction());
      return;
    }
  };
}

ThunkAction<AppState> gallery_image_save({dynamic photo}) {
  return (Store<AppState> store) async {
    store.dispatch(ImageLoader());

    var response = await GalleryRepository().saveGalleryImage(photo: photo);

    if (response.result!) {
      store.dispatch(galleryImageMiddleware());
      store.dispatch(accountMiddleware());
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.success));
    } else {
      // store.dispatch(galleryImageMiddleware());

      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.failure));
    }

    store.dispatch(ImageLoader());
  };
}

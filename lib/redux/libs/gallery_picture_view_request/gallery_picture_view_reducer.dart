
import 'package:active_matrimonial_flutter_app/models_response/gallery_picture_view_request_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_state.dart';

enum GalleryPicture { isFetch, profile_accept, reloadlist}

class GetGalleryPictureViewAction {
  @override
  String toString() {
    return 'GetGalleryPictureViewAction{}';
  }
}

class GetGalleryPictureViewSucceededAction {
  GalleryPictureViewRequestGetResponse? gallerypictureviewlist;


  @override
  String toString() {
    return 'GetGalleryPictureViewSucceededAction{gallerypictureviewlist: $gallerypictureviewlist}';
  }

  GetGalleryPictureViewSucceededAction({this.gallerypictureviewlist});
}

class GetGalleryPictureViewFailureAction {
  String? error;

  GetGalleryPictureViewFailureAction({this.error});

  @override
  String toString() {
    return 'GetGalleryPictureViewFailureAction{error: $error}';
  }
}

GalleryPictureViewState? gallery_picture_view_reducer(
    GalleryPictureViewState? state, dynamic action) {
  if (action is GetGalleryPictureViewAction) {
    state!.galleryStatus = GalleryStatus.loading;
    return state;
  }
  if (action is GetGalleryPictureViewSucceededAction) {
    state!.galleryStatus = GalleryStatus.success;
    state.showLoading = false;
    if(action.gallerypictureviewlist!.meta!.lastPage == state.page || action.gallerypictureviewlist!.data!.isEmpty){
      state.noMoreData = true;
    }
    state.galleryPictureViewList!.addAll(action.gallerypictureviewlist!.data!);
    // state.galleryPictureViewList = state.galleryPictureViewList + action.gallerypictureviewlist;
    return state;
  }
  if (action is GetGalleryPictureViewFailureAction) {
    state!.galleryStatus = GalleryStatus.failure;
    state.error = action.error;
    return state;
  }if(action is GalleryPictureViewReset){
    state = GalleryPictureViewState.initial();
    return state;
  }
  // if (action == GalleryPicture.profile_accept) {
  //   return accept(state, action);
  // }
  return state;
}


class GalleryPictureViewReset{}
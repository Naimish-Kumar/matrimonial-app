import 'package:active_matrimonial_flutter_app/models_response/profile_picture_view_request_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_state.dart';

enum ProfilePicture { isFetch, profile_accept, reloadlist }
class PictureProfileReset{}
//////////////////######################################################
class GetProfilePictureViewAction {
  @override
  String toString() {
    return 'GetProfilePictureViewAction{}';
  }
}

class GetProfilePictureViewSucceededAction {
  ProfilePictureViewRequestGetResponse? profileypictureviewlist;

  @override
  String toString() {
    return 'GetProfilePictureViewSucceededAction{profileypictureviewlist: $profileypictureviewlist}';
  }

  GetProfilePictureViewSucceededAction({this.profileypictureviewlist});
}

class GetProfilePictureViewFailureAction {
  String? error;

  GetProfilePictureViewFailureAction({this.error});

  @override
  String toString() {
    return 'GetProfilePictureViewFailureAction{error: $error}';
  }
}


PictureProfileViewState? profile_picture_view_reducer(
    PictureProfileViewState? state, dynamic action) {
  if (action is GetProfilePictureViewAction) {
    state!.pictureProfileStatus = PictureProfileStatus.loading;
    return state;
  }


  if (action is GetProfilePictureViewSucceededAction) {
    state!.pictureProfileStatus = PictureProfileStatus.success;
    state.showLoading = false;
    if( action.profileypictureviewlist!.meta!.lastPage == state.page || action.profileypictureviewlist!.data!.isEmpty ){
      state.noMoreData = true;
    }
    state.pictureProfileList!.addAll(action.profileypictureviewlist!.data!);
    return state;
  }


  if (action is GetProfilePictureViewFailureAction) {
    state!.pictureProfileStatus = PictureProfileStatus.failure;
    state.error = action.error;

    return state;
  }
if(action is  PictureProfileReset){
  state= PictureProfileViewState.initial();
  return state;
}
  return state;
}

import 'package:flutter/material.dart';

// class ProfilePictureViewState {
//   final ProfilePictureViewRequestGetResponse
//       profilePictureViewRequestGetResponse;
//   var index;
//   var isFetching;
//
//   CommonResponse profile_picture_accept_reject;
//
//   ProfilePictureViewState(
//       {this.profilePictureViewRequestGetResponse,
//       this.isFetching,
//       this.index,
//       this.profile_picture_accept_reject});
//
//   ProfilePictureViewState.initialState()
//       : profilePictureViewRequestGetResponse =
//             ProfilePictureViewRequestGetResponse.initialState(),
//         isFetching = false;
// }
///////////////////###############################################
// set enums
enum PictureProfileStatus { initial, loading, success, failure }

// state
class PictureProfileViewState {
  PictureProfileStatus? pictureProfileStatus;
  List<dynamic>? pictureProfileList = [];
  var error;
  var index;
  BuildContext? loadingContext;

  var dataFetch;
  var page;
  var totalData;
  var showLoading;
  var noMoreData;

  PictureProfileViewState({
    this.pictureProfileStatus,
    this.pictureProfileList,
    this.error,
    this.loadingContext,
    this.index,
    this.page,
    this.totalData,
    this.dataFetch,
    this.showLoading,
    this.noMoreData,
  });

  @override
  String toString() {
    return 'PictureProfileViewState{pictureProfileStatus: $pictureProfileStatus, pictureProfilelist: $pictureProfileList, error: $error, index: $index}';
  }

  factory PictureProfileViewState.initial() {
    return PictureProfileViewState(
      pictureProfileStatus: PictureProfileStatus.initial,
      pictureProfileList: [],
      error: '',
      page: 1,
      totalData: 0,
      dataFetch: false,
      showLoading: true,
      noMoreData: false,
    );
  }
}

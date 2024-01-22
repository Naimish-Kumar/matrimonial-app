import 'package:flutter/cupertino.dart';

enum GalleryStatus { initial, loading, success, failure }

class GalleryPictureViewState {
  GalleryStatus? galleryStatus;
  List<dynamic>? galleryPictureViewList = [];
  BuildContext? loadingContext;
  var error;
  var index;

  var dataFetch;
  var page;
  var totalData;
  var showLoading;
  var noMoreData;

  GalleryPictureViewState({
    this.galleryStatus,
    this.galleryPictureViewList,
    this.error,
    this.loadingContext,
    this.index,
    this.dataFetch,
    this.page,
    this.totalData,
    this.showLoading,
    this.noMoreData,
  });

  factory GalleryPictureViewState.initial() {
    return GalleryPictureViewState(
      galleryStatus: GalleryStatus.initial,
      galleryPictureViewList: [],
      error: '',
      page: 1,
      totalData: 0,
      dataFetch: false,
      showLoading: true,
      noMoreData: false,
    );
  }

  @override
  String toString() {
    return 'Gallerypictureviewstate{galleryStatus: $galleryStatus, galleryPictureViewList: $galleryPictureViewList, error: $error}';
  }
}

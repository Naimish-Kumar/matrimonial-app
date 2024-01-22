import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../models_response/Explore/slider_response.dart';
import '../../../repository/explore_repository.dart';
import '../../../screens/core.dart';
import '../../app/app_state.dart';

class LandingState {
  final CarouselController carouselController = CarouselController();
  int? carouselIndex = 0;
  // slider
  bool? isFetchingSlider;
  List? sliderImageList = [];
  String? sliderError;

  LandingState(
      {this.carouselIndex,
      this.isFetchingSlider,
      this.sliderImageList,
      this.sliderError});

  LandingState.initialState()
      : carouselIndex = 0,
        isFetchingSlider = true,
        sliderImageList = [],
        sliderError = '';
}

LandingState? landingReducer(LandingState? state, dynamic action) {
  if (action is SetCarouselIndexAction) {
    state!.carouselIndex = action.index;
    return state;
  }
  if (action is LandingSliderStoreAction) {
    state!.isFetchingSlider = false;
    state.sliderImageList = action.payload!.data;
    return state;
  }
  if (action is LandingSliderFailureAction) {
    state!.sliderError = action.error;
    return state;
  }
  return state;
}

class SetCarouselIndexAction {
  int? index;

  SetCarouselIndexAction({this.index});

  @override
  String toString() {
    return 'SetCarouselIndexAction{index: $index}';
  }
}

class LandingSliderStoreAction {
  SliderResponse? payload;

  LandingSliderStoreAction({this.payload});

  @override
  String toString() {
    return 'LandingSliderStoreAction{payload: $payload}';
  }
}

class LandingSliderFailureAction {
  String? error;

  LandingSliderFailureAction({this.error});

  @override
  String toString() {
    return 'LandingSliderFailureAction{payload: $error}';
  }
}

ThunkAction<AppState> fetchLandingSliderAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchSliderImages();
      store.dispatch(LandingSliderStoreAction(payload: data));
    } catch (e) {
      store.dispatch(LandingSliderFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

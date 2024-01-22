import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_action.dart';
import 'package:active_matrimonial_flutter_app/repository/explore_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> fetchSliderAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchSliderImages();
      store.dispatch(SliderStoreAction(payload: data));
    } catch (e) {
      store.dispatch(SliderFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchPremiumMembersAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchPremiumMembers();
      store.dispatch(PremiumMembersStoreAction(payload: data));
    } catch (e) {
      store.dispatch(PremiumMembersFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchBannerAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchBanner();
      store.dispatch(BannerStoreAction(payload: data));
    } catch (e) {
      store.dispatch(BannerFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchTrustedByAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchTrustedBy();
      store.dispatch(TrustedByStoreAction(payload: data));
    } catch (e) {
      store.dispatch(TrustedByFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchNewMembersAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchNewMembers();
      store.dispatch(NewMembersStoreAction(payload: data));
    } catch (e) {
      store.dispatch(NewMembersFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchHappyStoriesAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchHappyStories();
      store.dispatch(EHappyStoriesStoreAction(payload: data));
    } catch (e) {
      store.dispatch(EHappyStoriesFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchPackagesAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchPackages();
      store.dispatch(PackageStoreAction(payload: data));
    } catch (e) {
      store.dispatch(PackageFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchReviewAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchReviews();
      store.dispatch(ReviewStoreAction(payload: data));
    } catch (e) {
      store.dispatch(ReviewFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> fetchBlogsAction() {
  return (Store<AppState> store) async {
    try {
      var data = await ExploreRepository().fetchBlogs();
      store.dispatch(BlogStoreAction(payload: data));
    } catch (e) {
      store.dispatch(BlogFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

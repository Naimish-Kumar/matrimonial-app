import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/add_ignore_middleware.dart';
import 'package:flutter/material.dart';

HomeState? home_reducer(HomeState? state, action) {
  if (action is AddToIgnoreListFromHome) {
    return add_to_ignore(state!, action);
  }

  if (action is HomeStoreAction) {
    state!.isFetching = false;
    state.homeDataList = action.payload!.data;
    return state;
  }

  if (action is HomeFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action is SetCurrentIndex) {
    state!.currentIndex = action.payload;
    return state;
  }

  if (action is GoNextPage) {
    state!.controller!.animateToPage(
      state.currentIndex! + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    return state;
  }

  if (action is GoPrevPage) {
    state!.controller!.animateToPage(
      state.currentIndex! - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  return state;
}

add_to_ignore(HomeState state, AddToIgnoreListFromHome action) {
  store.dispatch(addIgnoreMiddleware(userId: action.user.userId!));
  state.homeDataList!.remove(action.user);

  return state;
}

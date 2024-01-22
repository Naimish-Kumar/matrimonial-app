import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/hobbies_interest_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/hobbies_interest_state.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../manage_profile_middleware/manage_profile_update_middlewares.dart';

class HobbiesInterestLoader {}

HobbiesInterestState? hobbies_interest_reducer(
    HobbiesInterestState? state, dynamic action) {
  if (action is HobbiesInterestLoader) {
    state!.isLoading = !state.isLoading!;
    return state;
  }

  if (action is HobbiesInterestStoreAction) {
    state!.hobbiesInterestData = action.payload!.data;
    setHobbiesInterest(state);
    return state;
  }

  //update info
  if (action == UpdateInfo.hobbiesInterest) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.formKey.currentState!.validate()) {
      store.dispatch(
        hobbiesInterestUpdateMiddleware(
          hobbies: state.hobbiesController!.text,
          interests: state.interestsController!.text,
          music: state.musicController!.text,
          books: state.booksController!.text,
          movies: state.moviesController!.text,
          tv_shows: state.tvShowController!.text,
          sports: state.sportsController!.text,
          fitness_activites: state.fitnessActivitiesController!.text,
          cuisines: state.cuisinesController!.text,
          dress_styles: state.dressStylesController!.text,
        ),
      );
    }
  }

  return state;
}

setHobbiesInterest(HobbiesInterestState? state) {
  state!.hobbiesController!.text = state.hobbiesInterestData!.hobbies!;
  state.interestsController!.text = state.hobbiesInterestData!.interests!;
  state.musicController!.text = state.hobbiesInterestData!.music!;
  state.booksController!.text = state.hobbiesInterestData!.books!;
  state.moviesController!.text = state.hobbiesInterestData!.movies!;
  state.tvShowController!.text = state.hobbiesInterestData!.tvShows!;
  state.sportsController!.text = state.hobbiesInterestData!.sports!;
  state.fitnessActivitiesController!.text =
      state.hobbiesInterestData!.fitnessActivities!;
  state.cuisinesController!.text = state.hobbiesInterestData!.cuisines!;
  state.dressStylesController!.text = state.hobbiesInterestData!.dressStyles!;
}

// action
class HobbiesInterestStoreAction {
  HobbiesInterestGetResponse? payload;

  HobbiesInterestStoreAction({this.payload});

  @override
  String toString() {
    return 'HobbiesInterestStoreAction{payload: $payload}';
  }
}

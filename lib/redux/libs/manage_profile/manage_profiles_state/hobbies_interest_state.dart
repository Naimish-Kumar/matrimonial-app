import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/hobbies_interest_get_response.dart';
import 'package:flutter/material.dart';

class HobbiesInterestState {
  bool? isLoading;
  TextEditingController? hobbiesController = TextEditingController();
  TextEditingController? interestsController = TextEditingController();
  TextEditingController? musicController = TextEditingController();
  TextEditingController? booksController = TextEditingController();

  TextEditingController? moviesController = TextEditingController();
  TextEditingController? tvShowController = TextEditingController();
  TextEditingController? sportsController = TextEditingController();
  TextEditingController? fitnessActivitiesController = TextEditingController();
  TextEditingController? cuisinesController = TextEditingController();
  TextEditingController? dressStylesController = TextEditingController();
  HobbiesInterestData? hobbiesInterestData;
  final formKey = GlobalKey<FormState>();

  HobbiesInterestState({
    this.hobbiesInterestData,
    this.isLoading,
    this.hobbiesController,
    this.interestsController,
    this.musicController,
    this.booksController,
    this.moviesController,
    this.tvShowController,
    this.sportsController,
    this.fitnessActivitiesController,
    this.cuisinesController,
    this.dressStylesController,
  });

  HobbiesInterestState.initialState()
      : isLoading = false,
        hobbiesInterestData = null,
        hobbiesController = TextEditingController(text: ''),
        interestsController = TextEditingController(text: ''),
        musicController = TextEditingController(text: ''),
        booksController = TextEditingController(text: ''),
        moviesController = TextEditingController(text: ''),
        tvShowController = TextEditingController(text: ''),
        sportsController = TextEditingController(text: ''),
        fitnessActivitiesController = TextEditingController(text: ''),
        cuisinesController = TextEditingController(text: ''),
        dressStylesController = TextEditingController(text: '');
}

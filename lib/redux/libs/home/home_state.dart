import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';
import 'package:flutter/material.dart';

class HomeState {
  bool? isFetching;
  List<MemberData>? homeDataList;
  String? error;
  int? currentIndex;
  PageController? controller =
      PageController(initialPage: 0, viewportFraction: 1);

  TextEditingController? reportController = TextEditingController();

  HomeState({
    this.error,
    this.isFetching,
    this.homeDataList,
    this.currentIndex,
    this.controller,
    this.reportController,
  });

  HomeState.initialState()
      : isFetching = true,
        error = '',
        currentIndex = 0,
        homeDataList = [];
}

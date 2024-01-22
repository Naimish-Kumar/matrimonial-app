import 'package:flutter/material.dart';

import '../../../../models_response/manage_profile/get_manage_profile/attitude_behavior_get_response.dart';

class AttitudeBehaviorState {
  bool? isLoading;

  final formKey = GlobalKey<FormState>();

  TextEditingController? affectionController = TextEditingController();
  TextEditingController? humorController = TextEditingController();
  TextEditingController? religiousServiceController = TextEditingController();
  TextEditingController? politicalViewsController = TextEditingController();

  AttitudeBehaviorData? attitudeBehaviorData;

  AttitudeBehaviorState({
    this.isLoading,
    this.affectionController,
    this.humorController,
    this.religiousServiceController,
    this.politicalViewsController,
    this.attitudeBehaviorData,
  });

  AttitudeBehaviorState.initialState()
      : isLoading = false,
        attitudeBehaviorData = null,
        affectionController = TextEditingController(text: ''),
        humorController = TextEditingController(text: ''),
        religiousServiceController = TextEditingController(text: ''),
        politicalViewsController = TextEditingController(text: '');
}

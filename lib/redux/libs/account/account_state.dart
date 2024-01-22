import 'package:active_matrimonial_flutter_app/models_response/account_response.dart';
import 'package:flutter/material.dart';

class AccountState {
  ProfileData? profileData;
  String? error;
  PageController matched_profile_controller = PageController();
  ScrollController gridScrollController = ScrollController();

  @override
  String toString() {
    return 'AccountState{profileData: $profileData, error: $error}';
  }

  AccountState({
    this.error,
    this.profileData,
  });

  AccountState.initialState()
      : profileData = null,
        error = '';
}

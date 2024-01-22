import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/family_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/family_state.dart';
import 'package:flutter/material.dart';

import '../../../../enums/enums.dart';
import '../../../../main.dart';
import '../manage_profile_middleware/manage_profile_update_middlewares.dart';

class Loader {}

FamilyState? family_reducer(FamilyState? state, dynamic action) {
  if (action is Loader) {
    state!.isloading = !state.isloading!;
    return state;
  }
  if (action == SaveChanges.familyInfo) {
    state!.pageloader = !state.pageloader!;
    return state;
  }

  if (action is FamilyStoreAction) {
    state!.familyData = action.payload!.data;
    setFamily(state);
    return state;
  }

  if (action == UpdateInfo.family) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.formKey.currentState!.validate()) {
      store.dispatch(
        familyUpdateMiddleware(
          father: state.fatherController!.text,
          mother: state.motherController!.text,
          sibling: state.siblingController!.text,
        ),
      );
    }
  }

  return state;
}

setFamily(FamilyState? state) {
  state!.fatherController!.text = state.familyData!.father!;
  state.motherController!.text = state.familyData!.mother!;
  state.siblingController!.text = state.familyData!.sibling!;
}

// actions
class FamilyStoreAction {
  FamilyGetResponse? payload;

  FamilyStoreAction({this.payload});

  @override
  String toString() {
    return 'FamilyStoreAction{payload: $payload}';
  }
}

import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/spiritual_social_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/sub_caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/spiritual_social_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';

class SLoader {}

class SpiritualSaveChanges {}

SpiritualSocialState? spiritual_reducer(
    SpiritualSocialState? state, dynamic action) {
  if (action is SLoader) {
    state!.set_sloader();
    return state;
  }

  if (action is SpiritualSaveChanges) {
    state!.set_sp_save_change();
    return state;
  }

  if (action is CasteResponse) {
    print("spirtual");
    return caste_response(state!, action);
  }
  if (action is SubcasteResponse) {
    return sub_caste_response(state!, action);
  }

  if (action is SpiritualSocialGetResponse) {
    return spiritual_social_get_response(state!, action);
  }
  if (action is AddReligionValueAction) {
    return add_religion_value(state!, action);
  }

  if (action is AddCasteValueAction) {
    return add_caste_value(state!, action);
  }

  if (action is AddSubCasteValueAction) {
    return add_sub_caste_value(state!, action);
  }

  if (action is AddFamilyValueAction) {
    return add_family_value(state!, action);
  }

  if (action is EmptyCasteAction) {
    return caste_list_clear(state!, action);
  }

  if (action is EmptySubCasteAction) {
    return subcaste_list_clear(state!, action);
  }

  return state;
}

/// profile drop down response

/// spiritual social get response
spiritual_social_get_response(
    SpiritualSocialState state, SpiritualSocialGetResponse action) {
  state.spiritualSocialGetResponse!.data = action.data;
  state.spiritualSocialGetResponse!.result = action.result;
  return state;
}

///set values;
add_religion_value(SpiritualSocialState state, AddReligionValueAction action) {
  state.religion_val = action.value;
  return state;
}

add_family_value(SpiritualSocialState state, AddFamilyValueAction action) {
  state.family_val = action.value;
  return state;
}

///caste
caste_response(SpiritualSocialState state, CasteResponse action) {
  state.casteResponse!.data!.addAll(action.data!);

  if (state.casteResponse!.data!.isNotEmpty) {
    state.caste_val = state.casteResponse!.data!.first;
    if (state.spiritualSocialGetResponse!.result!) {
      state.casteResponse!.data!.forEach((element) {
        if (element.name == state.spiritualSocialGetResponse!.data?.casteId) {
          state.caste_val = element;
        }
      });
    }
    store.dispatch(subcasteMiddleware(state.caste_val!.id));
  }
  return state;
}

add_caste_value(SpiritualSocialState state, AddCasteValueAction action) {
  // state.set_caste_val(action.value);
  state.caste_val = action.value;
  return state;
}

/// subcaste
sub_caste_response(SpiritualSocialState state, SubcasteResponse action) {
  state.subcasteResponse!.data!.addAll(action.data!);

  if (state.subcasteResponse!.data!.isNotEmpty) {
    state.sub_caste_val = state.subcasteResponse!.data!.first;

    if (state.spiritualSocialGetResponse!.result!) {
      state.subcasteResponse!.data!.forEach((element) {
        if (element.name ==
            state.spiritualSocialGetResponse!.data!.subCasteId) {
          state.sub_caste_val = element;
        }
      });
    }
  }
  return state;
}

add_sub_caste_value(SpiritualSocialState state, AddSubCasteValueAction action) {
  state.sub_caste_val = action.value;
  return state;
}

caste_list_clear(SpiritualSocialState state, EmptyCasteAction action) {
  state.casteResponse!.data!.clear();
  state.caste_val = null;
  return state;
}

subcaste_list_clear(SpiritualSocialState state, EmptySubCasteAction action) {
  state.subcasteResponse!.data!.clear();
  state.sub_caste_val = null;
  return state;
}

/// classes
class EmptyCasteAction {}

class EmptySubCasteAction {}

class AddReligionValueAction {
  var value;

  AddReligionValueAction({this.value});
}

class AddCasteValueAction {
  var value;

  AddCasteValueAction({this.value});
}

class AddSubCasteValueAction {
  var value;

  AddSubCasteValueAction({this.value});
}

class AddFamilyValueAction {
  var value;

  AddFamilyValueAction({this.value});
}

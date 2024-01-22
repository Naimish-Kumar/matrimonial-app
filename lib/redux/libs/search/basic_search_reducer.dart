import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/basic_search_state.dart';

import '../../../enums/enums.dart';
import 'search_action.dart';

BasicSearchState? basic_search_reducer(BasicSearchState? state, dynamic action) {
  // store search data
  if (action is SearchStoreAction) {
    state!.isFetching = false;
    state.searchList = action.payload!.data!.members;
    return state;
  }
  if (action is SearchFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.search) {
    state = BasicSearchState.initialState();
    return state;
  }
  //others
  if (action is CasteResponse) {
    return caste_response(state!, action);
  }

  if (action is SubcasteResponse) {
    return sub_caste_response(state!, action);
  }

  if (action is SearchGetStateValueAction) {
    return state_response(state!, action);
  }
  if (action is SearchGetCityValueAction) {
    return city_response(state!, action);
  }
  if (action is SearchAddCasteValueAction) {
    state!.caste_value = action.value;
    return state;
  }
  if (action is SearchAddReligionValueAction) {
    state!.religion_value = action.value;
    return state;
  }
  if (action is SearchAddSubCasteValueAction) {
    state!.sub_caste_value = action.value;
    return state;
  }

  if (action is SearchCountryAddValueAction) {
    state!.country_value = action.value;
    return state;
  }
  if (action is SearchStateAddValueAction) {
    state!.state_value = action.value;
    return state;
  }
  if (action is SearchCityAddValueAction) {
    state!.city_value = action.value;
    return state;
  }
  if (action is SearchEmptyCaste) {
    return empty_caste(state!, action);
  }
  if (action is SearchEmptySubCaste) {
    return empty_sub_caste(state!, action);
  }
  if (action is SearchEmptyState) {
    return empty_state(state!, action);
  }
  if (action is SearchEmptyCity) {
    return empty_city(state!, action);
  }

  if (action == BasicSearchRemove.motherTongueClear) {
    return basic_search_mother_tongue_clear(state!, action);
  }
  if (action == BasicSearchRemove.religionClear) {
    return basic_search_religion_clear(state!, action);
  }
  if (action is BasicSearchMotherTongueAdd) {
    return addMotherTongue(state!, action);
  }
  if (action is BasicSearchReligionAdd) {
    return addReligionValue(state!, action);
  }

  return state;
}

addReligionValue(BasicSearchState state, BasicSearchReligionAdd action) {
  state.religion_value = action.value;
  return state;
}

addMotherTongue(BasicSearchState state, BasicSearchMotherTongueAdd action) {
  state.mother_tongue = action.value;
  return state;
}

basic_search_mother_tongue_clear(BasicSearchState state, dynamic action) {
  state.mother_tongue = null;
  return state;
}

basic_search_religion_clear(BasicSearchState state, dynamic action) {
  state.religion_value = null;
  return state;
}

/// empty caste value
empty_caste(BasicSearchState state, SearchEmptyCaste action) {
  state.casteResponse!.data!.clear();
  state.caste_value = null;
  return state;
}

empty_sub_caste(BasicSearchState state, SearchEmptySubCaste action) {
  state.subcasteResponse!.data!.clear();
  state.sub_caste_value = null;
  return state;
}

empty_state(BasicSearchState state, SearchEmptyState action) {
  state.stateResponse!.data!.clear();
  state.state_value = null;
  return state;
}

empty_city(BasicSearchState state, SearchEmptyCity action) {
  state.cityResponse!.data!.clear();
  state.city_value = null;
  return state;
}

///-----------------------------------------------------------------------------

caste_response(BasicSearchState state, CasteResponse action) {
  state.casteResponse!.data = action.data;
  return state;
}

sub_caste_response(BasicSearchState state, SubcasteResponse action) {
  state.subcasteResponse!.data = action.data;
  return state;
}

state_response(BasicSearchState state, SearchGetStateValueAction action) {
  state.stateResponse!.data = action.data;
  return state;
}

city_response(BasicSearchState state, SearchGetCityValueAction action) {
  state.cityResponse!.data = action.data;
  return state;
}

///classes

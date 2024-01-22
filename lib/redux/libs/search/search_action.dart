import 'package:active_matrimonial_flutter_app/models_response/search/basic_search_response/basic_search_response.dart';

import '../../../models_response/common_models/ddown.dart';

class SearchStoreAction {
  BasicSearchResponse? payload;

  SearchStoreAction({this.payload});

  @override
  String toString() {
    return 'SearchStoreAction{payload: $payload}';
  }
}

class SearchFailureAction {
  String? error;

  SearchFailureAction({this.error});

  @override
  String toString() {
    return 'SearchFailureAction{error: $error}';
  }
}

/// classes

class SearchGetStateValueAction {
  List<DDown>? data;

  SearchGetStateValueAction(this.data);
}

class SearchGetCityValueAction {
  List<DDown>? data;

  SearchGetCityValueAction(this.data);
}

class SearchAddCasteValueAction {
  var value;

  SearchAddCasteValueAction({this.value});
}

class SearchAddReligionValueAction {
  var value;

  SearchAddReligionValueAction({this.value});
}

class SearchAddSubCasteValueAction {
  var value;

  SearchAddSubCasteValueAction({this.value});
}

class SearchCountryAddValueAction {
  var value;

  SearchCountryAddValueAction({this.value});
}

class SearchStateAddValueAction {
  var value;

  SearchStateAddValueAction({this.value});
}

class SearchCityAddValueAction {
  var value;

  SearchCityAddValueAction({this.value});
}

class SearchEmptyCaste {}

class SearchEmptySubCaste {}

class SearchEmptyState {}

class SearchEmptyCity {}

enum BasicSearchRemove { motherTongueClear, religionClear }

class BasicSearchMotherTongueAdd {
  var value;

  BasicSearchMotherTongueAdd({this.value});
}

class BasicSearchReligionAdd {
  var value;

  BasicSearchReligionAdd({this.value});
}

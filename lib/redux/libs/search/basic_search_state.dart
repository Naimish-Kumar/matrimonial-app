import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';

class BasicSearchState {
  bool? isFetching;
  List? searchList = [];
  String? error;

  final CasteResponse? casteResponse;
  final SubcasteResponse? subcasteResponse;

  final StateResponse? stateResponse;
  final CityResponse? cityResponse;

  var religion_value;
  var caste_value;
  var sub_caste_value;

  var country_value;
  var state_value;
  var city_value;
  var mother_tongue;
  bool? search_loader;

  BasicSearchState({
    this.casteResponse,
    this.subcasteResponse,
    this.stateResponse,
    this.cityResponse,
    this.isFetching,
    this.searchList,
    this.error,
  });

  BasicSearchState.initialState()
      : casteResponse = CasteResponse.initialState(),
        isFetching = true,
        searchList = [],
        error = '',
        subcasteResponse = SubcasteResponse.initialState(),
        search_loader = false,
        stateResponse = StateResponse.initialState(),
        cityResponse = CityResponse.initialState();
}

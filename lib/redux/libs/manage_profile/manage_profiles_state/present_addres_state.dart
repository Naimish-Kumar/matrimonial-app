import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/present_address_get_response.dart';

class PresentAddressState {
  PresentAddressData? presentAddressData;
  bool? result;

  bool? isLoading;
  bool? saveChangesLoader;
  final StateResponse? stateResponse;
  final CityResponse? cityResponse;

  DDown? selected_state;
  DDown? selected_city;
  DDown? selected_country;

  save_chagnes_toogler() {
    this.saveChangesLoader = !saveChangesLoader!;
  }

  page_loader_toogler() {
    this.isLoading = !isLoading!;
  }

  PresentAddressState({
    this.isLoading,
    this.saveChangesLoader,
    this.stateResponse,
    this.cityResponse,
  });

  PresentAddressState.initialState()
      : stateResponse = StateResponse.initialState(),
        cityResponse = CityResponse.initialState(),
        saveChangesLoader = false,
        isLoading = false;
}

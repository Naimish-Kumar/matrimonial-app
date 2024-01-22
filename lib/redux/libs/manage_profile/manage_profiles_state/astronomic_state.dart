import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/astronomic_get_response.dart';

class AstronomicState {
  bool? isloading;
  bool? pageloader;
  final AstronomicGetResponse? astronomicGetResponse;

  AstronomicState(
      {this.isloading, this.pageloader, this.astronomicGetResponse});

  AstronomicState.initialState()
      : astronomicGetResponse = AstronomicGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}

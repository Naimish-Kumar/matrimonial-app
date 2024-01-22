import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/residency_get_response.dart';

class ResidencyState {
  bool? isloading;
  bool? pageloader;
  final ResidencyGetResponse? residencyGetResponse;

  ResidencyState({this.residencyGetResponse, this.isloading, this.pageloader});

  ResidencyState.initialState()
      : residencyGetResponse = ResidencyGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}

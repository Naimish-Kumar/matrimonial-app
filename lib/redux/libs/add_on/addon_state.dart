import 'package:active_matrimonial_flutter_app/models_response/addon_check_response.dart';

class AddonState {
  AddonState({
    this.data,
    this.error,
  });

  AddonData? data;
  String? error;

  AddonState.initialState()
      : data = null,
        error = '';
}

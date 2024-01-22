import 'package:active_matrimonial_flutter_app/models_response/feature_check_response.dart';

class SystemSettingState {
  SystemSettingResponse? settingResponse;

  bool? isMinimumAge;

  SystemSettingState({
    this.settingResponse,
    this.isMinimumAge,
  });

  SystemSettingState.initialState()
      : settingResponse = null,
        isMinimumAge = false;
}

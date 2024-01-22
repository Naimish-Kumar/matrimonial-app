import 'package:active_matrimonial_flutter_app/models_response/feature_check_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_state.dart';

class FetchFeatureAction {
  SystemSettingResponse payload;

  FetchFeatureAction({required this.payload});

  @override
  String toString() {
    return 'FetchFeatureAction{payload: $payload}';
  }
}

SystemSettingState? feature_reducer(SystemSettingState? state, dynamic action) {
  if (action is FetchFeatureAction) {
    return fetch_feature(state!, action);
  }
  return state;
}

fetch_feature(SystemSettingState state, dynamic action) {
  state.settingResponse = action.payload;
  state.isMinimumAge = (state.settingResponse?.data!['member_min_age'] != "") &&
      (state.settingResponse?.data!['member_min_age'] != null);
  return state;
}

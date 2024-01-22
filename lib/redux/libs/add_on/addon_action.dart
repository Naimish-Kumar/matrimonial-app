import 'package:active_matrimonial_flutter_app/models_response/addon_check_response.dart';

class AddonFailureAction {
  String? error;

  AddonFailureAction({this.error});

  @override
  String toString() {
    return 'AddonFailureAction{error: $error}';
  }
}

class AddonStoreAction {
  AddonCheckResponse? payload;

  @override
  String toString() {
    return 'AddonStoreAction{data: $payload}';
  }

  AddonStoreAction({this.payload});
}

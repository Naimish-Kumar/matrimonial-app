import 'package:active_matrimonial_flutter_app/models_response/package/package_list_response.dart';

class PremiumPlansState {
  List<dynamic>? premiumList = [];
  String? error;
  bool? isFetching;

  PremiumPlansState({this.isFetching, this.premiumList, this.error});

  PremiumPlansState.initialState()
      : premiumList = [],
        isFetching = true,
        error = '';

  @override
  String toString() {
    return 'PremiumPlansState{premiumList: $premiumList, error: $error, isFetching: $isFetching}';
  }
}

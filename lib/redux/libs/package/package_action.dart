import 'package:active_matrimonial_flutter_app/models_response/package/package_history_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/packge_details_response.dart';

class PackageHistoryStoreAction {
  PackageHistoryResponse? payload;

  PackageHistoryStoreAction({this.payload});

  @override
  String toString() {
    return 'PackageHistoryStoreAction{payload: $payload}';
  }
}

class PackageHistoryFailureAction {
  String? error;

  PackageHistoryFailureAction({this.error});

  @override
  String toString() {
    return 'PackageHistoryFailureAction{error: $error}';
  }
}

class PackageDetailsStoreAction {
  PackageDetailsResponse? payload;

  PackageDetailsStoreAction({this.payload});

  @override
  String toString() {
    return 'PackageDetailsStoreAction{payload: $payload}';
  }
}

class PackageDetailsFailureAction {
  String? error;

  PackageDetailsFailureAction({this.error});

  @override
  String toString() {
    return 'PackageDetailsFailureAction{payload: $error}';
  }
}

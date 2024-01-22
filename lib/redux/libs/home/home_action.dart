import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';
import 'package:active_matrimonial_flutter_app/models_response/home_response.dart';

class HomeStoreAction {
  HomeResponse? payload;

  HomeStoreAction({this.payload});

  @override
  String toString() {
    return 'HomeStoreAction{payload: $payload}';
  }
}

class HomeFailureAction {
  String? error;

  HomeFailureAction({this.error});

  @override
  String toString() {
    return 'HomeFailureAction{error: $error}';
  }
}

class AddToIgnoreListFromHome {
  var context;
  MemberData user;

  @override
  String toString() {
    return 'AddToIgnoreListFromHome{context: $context, user: $user}';
  }

  AddToIgnoreListFromHome({required this.user, this.context});
}

class SetCurrentIndex {
  int? payload;

  SetCurrentIndex({this.payload});

  @override
  String toString() {
    return 'SetCurrentIndex{payload: $payload}';
  }
}

class GoNextPage {
  @override
  String toString() {
    return 'GoNextPage{}';
  }
}

class GoPrevPage {
  @override
  String toString() {
    return 'GoPrevPage{}';
  }
}

import 'package:active_matrimonial_flutter_app/models_response/ignore/ignore_response.dart';

class IgnoreAction{}

class IgnoreLoading{}

class IgnoreItemRemoveAction{
  var context;
  var data;

  IgnoreItemRemoveAction({this.data, this.context});
}



class AddIgnoreAction{
  var user;

  AddIgnoreAction({this.user});
}

class IgnoreStoreAction{
  IgnoreResponse? payload;

  IgnoreStoreAction({this.payload});

  @override
  String toString() {
    return 'IgnoreStoreAction{payload: $payload}';
  }
}

class IgnoreFailureAction{
  String? error;

  IgnoreFailureAction({this.error});

  @override
  String toString() {
    return 'IgnoreFailureAction{error: $error}';
  }
}
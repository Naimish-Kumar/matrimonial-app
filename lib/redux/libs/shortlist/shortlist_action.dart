import 'package:active_matrimonial_flutter_app/models_response/shortlist/shortlist_response.dart';

class DeleteShortlist {}

class AddShortlistReset {}

class ShortListReset {
  bool? payload;

  ShortListReset({this.payload});

  @override
  String toString() {
    return 'ShortListReset{payload: $payload}';
  }
}

class StoreShortlist {
  ShortlistResponse? payload;

  @override
  String toString() {
    return 'StoreShortlist{payload: $payload}';
  }

  StoreShortlist({this.payload});
}

class ShortlistFailureAction {
  String? error;

  ShortlistFailureAction({this.error});

  @override
  String toString() {
    return 'ShortlistFailureAction{error: $error}';
  }
}

class ShortlistAction {}

class AddShortlistAction {
  final int? index;

  AddShortlistAction({this.index});
}

class RemoveShortlistAction {
  final dynamic index;
  var context;
  var data;

  RemoveShortlistAction({this.index, this.context, this.data});
}

class LoadAction {}

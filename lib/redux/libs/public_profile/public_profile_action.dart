class PublicProfileStoreAction {
  var data;

  @override
  String toString() {
    return 'PublicProfileStoreAction{data: $data}';
  }

  PublicProfileStoreAction({this.data});
}

class PublicProfileFailureAction {
  String? error;

  PublicProfileFailureAction({this.error});

  @override
  String toString() {
    return 'PublicProfileFailureAction{error: $error}';
  }
}

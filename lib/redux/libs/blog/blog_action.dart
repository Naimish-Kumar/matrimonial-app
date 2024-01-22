import '../../../models_response/blog_response.dart';

class BlogAction {}

class BlogStoreAction {
  BlogResponse? payload;

  BlogStoreAction({this.payload});

  @override
  String toString() {
    return 'BlogStoreAction{payload: $payload}';
  }
}

class BlogFailureAction {
  String? error;

  BlogFailureAction({this.error});

  @override
  String toString() {
    return 'BlogFailureAction{payload: $error}';
  }
}

import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';

class ShortlistState {
  bool? isLoading;
  int? index;
  int? delIndex;
  bool? delete;
  var page;
  late bool hasMore;
  String? error;
  bool? fullReset;

  List<MemberData>? shortlistData = [];
  bool? isFetching;

  ShortlistState({
    this.isLoading,
    this.shortlistData,
    this.delete,
    this.error,
    this.index,
    this.isFetching,
    this.fullReset,
  });

  ShortlistState.initialState()
      : shortlistData = [],
        isFetching = true,
        isLoading = false,
        delete = false,
        error = '',
        page = 1,
        fullReset = false,
        hasMore = true;
}

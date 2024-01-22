/// my interest state
class MyInterestState {
  bool? isLoading;

  // new
  var page;
  bool? hasMore;
  bool? isFetching;
  List<dynamic>? myInterestList = [];
  String? error;
  bool? fullReset;

  MyInterestState({
    this.page,
    this.fullReset,
    this.hasMore,
    this.error,
    this.isFetching,
    this.myInterestList,
    this.isLoading,
  });

  MyInterestState.initialState()
      : page = 1,
        error = '',
        fullReset = false,
        isFetching = true,
        myInterestList = [],
        hasMore = true,
        isLoading = false;
}

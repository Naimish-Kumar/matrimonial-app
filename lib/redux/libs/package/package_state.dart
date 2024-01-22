class PackageState {
  bool? hasMore;
  var page;
  List? packageHistoryList;

  bool? isFetching;
  String? error;

  PackageState({
    this.error,
    this.isFetching,
    this.hasMore,
    this.page,
    this.packageHistoryList,
  });

  PackageState.initialState()
      : hasMore = true,
        error = '',
        packageHistoryList = [],
        isFetching = true,
        page = 1;
}

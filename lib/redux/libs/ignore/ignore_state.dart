class IgnoreState {
  late bool isFetching;
  var page;
  late bool hasMore;
  List<dynamic>? ignoreList = [];
  String? error;

  IgnoreState({
    this.ignoreList,
    this.error,
  });

  IgnoreState.initialState()
      : isFetching = true,
        page = 1,
        hasMore = true,
        ignoreList = [],
        error = '';
}

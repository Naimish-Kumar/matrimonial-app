class InterestRequestState {
  var page;
  var index;
  bool? hasMore;
  bool? isFetching;
  bool? acceptInterest;

  List<dynamic>? interestRequestList = [];
  String? error;

  InterestRequestState({
    this.page,
    this.index,
    this.acceptInterest,
    this.hasMore,
    this.isFetching,
    this.interestRequestList,
    this.error,
  });

  InterestRequestState.initialState()
      : acceptInterest = false,
        hasMore = true,
        error = '',
        interestRequestList = [],
        isFetching = true,
        page = 1;
}

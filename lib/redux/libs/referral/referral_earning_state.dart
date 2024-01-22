class ReferralEarningState {
  int page=1;
  bool? hasMore;
  bool? isFetching;
  List<dynamic>? referralEarningList = [];
  String? error;

  ReferralEarningState({
    this.page=1,
    this.hasMore,
    this.isFetching,
    this.referralEarningList,
    this.error,
  });

  @override
  String toString() {
    return 'ReferralEarningState{page: $page, hasMore: $hasMore, isFetching: $isFetching, referralEarningList: $referralEarningList, error: $error}';
  }

  ReferralEarningState.initialState()
      : page = 1,
        hasMore = true,
        isFetching = true,
        referralEarningList = [],
        error = '';
}

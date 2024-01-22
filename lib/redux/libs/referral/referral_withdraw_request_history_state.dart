class ReferralWithdrawRequestHistoryState {
  int page=1;
  bool? isFetching;
  bool? hasMore;
  List<dynamic>? referralWithdrawRequestHistoryList = [];
  String? error;

  ReferralWithdrawRequestHistoryState({
    this.page=1,
    this.isFetching,
    this.hasMore,
    this.referralWithdrawRequestHistoryList,
    this.error,
  });

  ReferralWithdrawRequestHistoryState.initialState()
      : page = 1,
        isFetching = true,
        hasMore = true,
        referralWithdrawRequestHistoryList = [],
        error = '';

  @override
  String toString() {
    return 'ReferralWithdrawRequestHistoryState{page: $page, isFetching: $isFetching, hasMore: $hasMore, referralWithdrawRequestHistoryList: $referralWithdrawRequestHistoryList, error: $error}';
  }
}

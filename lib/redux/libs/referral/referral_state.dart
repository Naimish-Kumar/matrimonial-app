class ReferralState {
  String? referralCode;
  int page=1;
  bool? isFetching;
  bool? hasMore;
  List<dynamic>? referralUserList = [];
  String? error;
  String? referralCodeError;

  ReferralState({
    this.page=1,
    this.isFetching,
    this.referralCode,
    this.hasMore,
    this.referralUserList,
    this.error,
    this.referralCodeError,
  });

  ReferralState.initialState()
      : page = 1,
        referralCodeError = '',
        referralCode = '--------',
        hasMore = true,
        isFetching = true,
        referralUserList = [],
        error = '';
}

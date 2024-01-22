class MyWalletState {
  MyWalletState({
    this.isFetching,
    this.balance,
    this.balanceHistory,
    this.balanceError,
    this.historyError,
    this.hasMore,
    this.page=1,
  });

  bool? isFetching;
  String? balance;
  List? balanceHistory = [];
  String? balanceError;
  String? historyError;
  bool? hasMore;
  int page=1;

  MyWalletState.initialState()
      : isFetching = true,
        balance = "0.00",
        balanceError = '',
        historyError = '',
        hasMore = true,
        page = 1,
        balanceHistory = [];
}

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_state.dart';

MyWalletState? my_wallet_reducer(MyWalletState? state, dynamic action) {
  if (action is MyWalletBalanceStoreAction) {
    state!.balance = action.payload!.data!.walletBalance;
    return state;
  }
  if (action is MyWalletBalanceFailureAction) {
    state!.balanceError = action.error;
    return state;
  }

  if (action is MyWalletHistoryStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.balanceHistory!.addAll(action.payload!.data!);
    return state;
  }
  if (action is MyWalletHistoryFailureAction) {
    state!.historyError = action.error;
    return state;
  }
  if (action == Reset.myWallet) {
    state = MyWalletState.initialState();
    return state;
  }

  return state;
}

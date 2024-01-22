import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/premium_plans/premium_plans_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/package_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../screens/package/package_history.dart';
import '../account/account_middleware.dart';

ThunkAction<AppState> packageListMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await PackageRepository().fetchPackageList();

      store.dispatch(PackageListStoreAction(payload: data));
    } catch (e) {
      store.dispatch(PackageListFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> packageDetailsMiddleware({packageId}) {
  return (Store<AppState> store) async {
    try {
      var data =
          await PackageRepository().fetchPackageDetail(packageId: packageId);
      store.dispatch(PackageDetailsStoreAction(payload: data));
    } catch (e) {
      store.dispatch(PackageDetailsFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}

ThunkAction<AppState> packageHistoryMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.packageState!.page;

    try {
      var data = await PackageRepository().fetchPackageHistory(page: page);
      store.dispatch(PackageHistoryStoreAction(payload: data));
    } catch (e) {
      //debugPrint(e);
      store.dispatch(PackageHistoryFailureAction(error: e.toString()));
      return;
    }
  };
}

ThunkAction<AppState> packagePurchaseMiddleware(
    {amount, packageId, paymentMethod}) {
  return (Store<AppState> store) async {
    try {
      var data = await PackageRepository().packagePurchase(
          amount: amount, packageId: packageId, paymentMethod: paymentMethod);
      Navigator.pop(store.state.packagePaymentWithWalletState!.loadingContext!);
      if (data.result!) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));

        NavigatorPush.push_replace(page: PackageHistory());
        store.dispatch(accountMiddleware());
        store.dispatch(authMiddleware());
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}

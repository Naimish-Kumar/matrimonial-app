import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_action.dart';
import 'package:active_matrimonial_flutter_app/repository/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> paymentTypesMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await PaymentRepository().fetchPaymentTypes();
      store.dispatch(PaymentTypesStoreAction(payload: data));
    } catch (e) {
      store.dispatch(PaymentTypesFailureAction(error: e.toString()));
      //debugPrint(e.toString());
      return;
    }
  };
}

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_state.dart';

PaymentTypesState? payment_types_reducer(
    PaymentTypesState? state, dynamic action) {
  if (action is AddPaymentMethodKeyAction) {
    return add_payment_method_key(state!, action);
  }
  if (action is UpdatePaymentMethodKeyAction) {
    return update_payment_method_key(state!, action);
  }

  if (action is PaymentTypesStoreAction) {
    state!.isFetching = false;
    state.paymentTypes = action.payload!.data;
    return state;
  }
  if (action is PaymentTypesFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.paymentTypes) {
    state = PaymentTypesState.initialState();
    return state;
  }

  return state;
}

add_payment_method_key(
    PaymentTypesState state, AddPaymentMethodKeyAction action) {
  state.selected_payment_method = action.method;
  state.selected_payment_method_key = action.key;

  return state;
}

update_payment_method_key(
    PaymentTypesState state, UpdatePaymentMethodKeyAction action) {
  state.selected_payment_method_index = action.index;
  // package payment or not
  state.selected_payment_method = action.method;
  // payment type key
  state.selected_payment_method_key = action.key;
  //payment type for manual payment check only
  state.selected_payment_type = action.type;
  return state;
}

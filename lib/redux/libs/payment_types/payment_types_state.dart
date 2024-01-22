class PaymentTypesState {
  List? paymentTypes = [];
  String? error;
  bool? isFetching;
  var selected_payment_method_index;
  var selected_payment_type;
  var selected_payment_method_key;
  var selected_payment_method;

  PaymentTypesState({
    this.error,
    this.isFetching,
    this.paymentTypes,
  });

  PaymentTypesState.initialState()
      : error = '',
        isFetching = true,
        paymentTypes = [];
}

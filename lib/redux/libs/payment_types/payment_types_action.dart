import 'package:active_matrimonial_flutter_app/models_response/payments/payment_types_response.dart';

class PaymentTypesStoreAction {
  PaymentTypesResponse? payload;

  PaymentTypesStoreAction({this.payload});

  @override
  String toString() {
    return 'PaymentTypesStoreAction{payload: $payload}';
  }
}

class PaymentTypesFailureAction {
  String? error;

  PaymentTypesFailureAction({this.error});

  @override
  String toString() {
    return 'PaymentTypesFailureAction{error: $error}';
  }
}

class AddPaymentMethodKeyAction {
  var method;
  var key;

  @override
  String toString() {
    return 'AddPaymentMethodKeyAction{method: $method, key: $key}';
  }

  AddPaymentMethodKeyAction({this.method, this.key});
}

class UpdatePaymentMethodKeyAction {
  var method;
  var key;
  var index;
  var type;

  @override
  String toString() {
    return 'UpdatePaymentMethodKeyAction{method: $method, key: $key, index: $index, type: $type}';
  }

  UpdatePaymentMethodKeyAction({this.method, this.key, this.index, this.type});
}

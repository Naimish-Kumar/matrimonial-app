import 'dart:io';

import 'package:active_matrimonial_flutter_app/redux/libs/offline_payment/offline_payment_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/offline_payment/offline_payment_state.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../screens/core.dart';
import '../helpers/show_message_state.dart';
import '../wallet/wallet_recharge_middleware.dart';
import 'offline_payment_middleware.dart';

OfflinePaymentState? offlinePaymentReducer(
    OfflinePaymentState? state, dynamic action) {
  if (action is SetImageName) {
    state!.image = action.image;
    state.imgName = action.imageName;
    return state;
  }
  // submit data for package buying
  if (action is OfflineBuyPackageAction) {
    offlineBuyPackage(state, action);
  }
  // offline recharge wallet
  if (action is OfflineRechargeWalletAction) {
    offLineWalletRecharge(state, action);
  }
  if (action == Reset.offlinePayment) {
    state!.idController!.text = '';
    state.detailController!.text = '';
    state.image = null;
    state.imgName = null;
    return state;
  }
  return state;
}

offLineWalletRecharge(
    OfflinePaymentState? state, OfflineRechargeWalletAction action) {
  if (!requiredFieldVerification(state)) {
    return;
  }
  Map postValue = {};
  postValue.addAll({
    "amount": action.amount,
    "payment_option": "manual_payment",
    "manual_payment_id": action.manualPaymentId,
    "transaction_id": state!.idController!.text,
    "payment_proof": state.image,
    "payment_details": state.detailController!.text
  });
  store.dispatch(walletRechargeMiddleware(postBody: postValue));
  return state;
}

ThunkAction<AppState> getImageAction() {
  return (Store<AppState> store) async {
    try {
      final image = await store.state!.offlinePaymentState!.picker
          .pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tmpImage = File(image.path);
      store.dispatch(SetImageName(tmpImage.path.split('/').last, tmpImage));
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  };
}

offlineBuyPackage(
    OfflinePaymentState? state, OfflineBuyPackageAction action) async {
  if (!requiredFieldVerification(state)) {
    return;
  }

  Map postValue = {};
  postValue.addAll({
    "package_id": action.packageId,
    "amount": action.amount,
    "payment_option": "manual_payment",
    "manual_payment_id": action.manualPaymentId,
    "transaction_id": state!.idController!.text,
    "payment_proof": state.image,
    "payment_details": state.detailController!.text
  });

  store.dispatch(offlinePaymentMiddleware(postBody: postValue));
  return state;
}

bool requiredFieldVerification(OfflinePaymentState? state) {
  if (state!.idController!.text.trim().isEmpty) {
    store.dispatch(ShowMessageAction(msg: "Transaction id Can't be empty"));
    return false;
  } else if (state.imgName == null) {
    store.dispatch(ShowMessageAction(msg: "Payment proof Can't be empty"));
    return false;
  }
  return true;
}

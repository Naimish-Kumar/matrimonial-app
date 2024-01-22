import 'dart:io';

class SetImageName {
  String? imageName;
  File? image;

  SetImageName(this.imageName, this.image);

  @override
  String toString() {
    return 'SetImageName{imageName: $imageName}';
  }
}

class OfflineBuyPackageAction {
  String? packageId;
  String? amount;
  String? manualPaymentId;
  OfflineBuyPackageAction({
    this.amount,
    this.packageId,
    this.manualPaymentId,
  });

  @override
  String toString() {
    return 'OfflineBuyPackageAction{packageId: $packageId, amount: $amount, manualPaymentId: $manualPaymentId}';
  }
}

class OfflineRechargeWalletAction {
  String? amount;
  String? manualPaymentId;

  OfflineRechargeWalletAction({this.amount, this.manualPaymentId});

  @override
  String toString() {
    return 'OfflineRechargeWalletAction{amount: $amount, manualPaymentId: $manualPaymentId}';
  }
}

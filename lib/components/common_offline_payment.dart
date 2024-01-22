import 'package:active_matrimonial_flutter_app/components/group_item.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/offline_payment/offline_payment_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../const/style.dart';
import '../main.dart';
import '../redux/app/app_state.dart';
import '../redux/libs/offline_payment/offline_payment_reducer.dart';
import 'common_app_bar.dart';
import 'common_input.dart';

class CommonOfflinePayment extends StatefulWidget {
  var amount;
  String payment_type;
  String? payment_method_key;
  String package_id;
  var details;
  var manual_payment_id;
  String? title;

  CommonOfflinePayment({
    Key? key,
    this.amount = 0.00,
    this.payment_type = "",
    this.payment_method_key = "",
    this.package_id = "0",
    this.details,
    this.manual_payment_id,
    this.title,
  }) : super(key: key);

  @override
  State<CommonOfflinePayment> createState() => _CommonOfflinePaymentState();
}

class _CommonOfflinePaymentState extends State<CommonOfflinePayment> {
  double webViewHeight = 150.0;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  void initState() {
    super.initState();
    // print(amount);
    // print(payment_type);
    // print(payment_method_key);
    // print(package_id);
    // print(widget.details);
    // print(manual_payment_id);
    // print(title);
    // makeHeight();

    controller
        .loadHtmlString(html(widget.details))
        .then((value) => makeHeight());
  }

  makeHeight() async {
    await Future.delayed(Duration(seconds: 1));
    var h = await controller.runJavaScriptReturningResult(
        "document.getElementById('scaled-frame').clientHeight");

    webViewHeight = double.parse(
      (h).toString(),
    );
    setState(() {});
  }

  String html(body) {
    return ''' <!DOCTYPE html>
<html>
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=.8" shrink-to-fit=no>
  <style>
  body{
  color: #6d6e6f;
  }
  </style>
</head>

  <body>
  <div id="scaled-frame">
  $body
  </div>
  </body>
</html>
 ''';
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(text: widget.title).build(context),
        body: buildBody(state),
      ),
    );
  }

  Widget buildBody(AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal,
            vertical: Const.kPaddingVertical),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: webViewHeight,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
            Const.height20,
            const Divider(),
            GroupItem(
              name: "Transaction Id",
              hintText: "Transaction Id",
              controller: state.offlinePaymentState!.idController,
              isMandatory: true,
            ),
            Const.height10,
            GroupItemWithChild(
              title: "Payment Proof",
              style: Styles.bold_app_accent_12,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputStyle.inputDecoration_text_field(
                      hint: state.offlinePaymentState!.imgName ?? "Choose file",
                    ),
                  ),
                  Positioned(
                    right: 5,
                    child: SizedBox(
                      width: 100,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(MyTheme.white),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () => store.dispatch(getImageAction()),
                          child: Text(
                            'Browse',
                            style: Styles.regular_storm_grey_12,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Const.height10,
            GroupItem(
              name: "Payment Details",
              hintText: "Payment Details",
              controller: state.offlinePaymentState!.detailController,
              minLines: 5,
            ),
            Const.height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.app_accent_color),
                    fixedSize: MaterialStateProperty.all(
                      const Size(100.0, 20.0),
                    ),
                  ),
                  onPressed: () {
                    widget.payment_type == "wallet_payment"
                        ? store.dispatch(
                            // wallet recharge offline action
                            OfflineRechargeWalletAction(
                              amount: widget.amount.toString(),
                              manualPaymentId:
                                  widget.manual_payment_id.toString(),
                            ),
                          )
                        : store.dispatch(
                            // package purchase offline action
                            OfflineBuyPackageAction(
                              amount: widget.amount.toString(),
                              packageId: widget.package_id.toString(),
                              manualPaymentId:
                                  widget.manual_payment_id.toString(),
                            ),
                          );
                  },
                  child: state.offlinePaymentState!.isSubmit!
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: MyTheme.white,
                          ),
                        )
                      : Text(
                          'Confirm',
                          style: Styles.bold_white_12,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

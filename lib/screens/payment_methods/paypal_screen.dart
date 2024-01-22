import 'dart:convert';

import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/payment_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../redux/libs/helpers/show_message_state.dart';

class PaypalScreen extends StatefulWidget {
  String? amount;
  String? payment_type;
  String? payment_method_key;
  String? package_id;

  PaypalScreen({
    Key? key,
    this.amount,
    this.payment_type,
    this.payment_method_key,
    this.package_id,
  }) : super(key: key);

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  dynamic _initial_url;
  var accessToken = prefs.getString(Const.accessToken);
  var userId = store.state.authState!.userData!.id!;
  // var userId = prefs.getInt(Const.userId);
  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetInitialUrl();
  }

  paypal() {
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // onPageStarted: (controller) {
          //   _webViewController.loadRequest(Uri.parse(_initial_url), headers: {
          //     "Accept": "application/json",
          //     "Content-Type": "application/json",
          //     "Authorization": "Bearer $accessToken"
          //   });
          // },
          onWebResourceError: (error) {},
          onPageFinished: (page) {
            if (page.contains("/paypal/payment/done")) {
              getData();
            } else if (page.contains("/paypal/payment/cancel")) {
              Navigator.of(context).pop();
              return;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(_initial_url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
  }

  getSetInitialUrl() async {
    Map paypalUrlResponse = await (PaymentRepository().getPaypalUrlResponse(
      amount: widget.amount.toString(),
      payment_method: widget.payment_method_key,
      payment_type: widget.payment_type,
      package_id: widget.package_id,
      userId: userId,
    ));

    if (paypalUrlResponse.keys.toList()[0] == false) {
      store.dispatch(ShowMessageAction(
        msg: paypalUrlResponse.keys.toList()[2],
      ));

      Navigator.of(context).pop();
      return;
    }
    paypalUrlResponse.values.toList();
    _initial_url = paypalUrlResponse.values.toList()[1];
    setState(() {});
    paypal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppBar(text: AppLocalizations.of(context)!.paypal_screen_title)
              .build(context),
      body: buildBody(),
    );
  }

  void getData() {
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then(
      (data) {
        var decodedJSON = jsonDecode(data as String);
        Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
        if (responseJSON["result"] == false) {
          store.dispatch(ShowMessageAction(
            msg: responseJSON["message"],
          ));
          Navigator.pop(context);
        } else if (responseJSON["result"] == true) {
          store.dispatch(ShowMessageAction(
            msg: responseJSON["message"],
          ));
          if (widget.payment_type == "wallet_payment") {
            OneContext().navigator.push(
                  MaterialPageRoute(
                    builder: (context) => MyWallet(
                      from_wallet: true,
                    ),
                  ),
                );
          }
          if (widget.payment_type == "package_payment") {
            store.dispatch(accountMiddleware());

            // OneContext().navigator.push(
            //       MaterialPageRoute(
            //         builder: (context) => PackageHistory(
            //           from_package: true,
            //         ),
            //       ),
            //     );

            NavigatorPush.push_replace(
                page: PackageHistory(
              from_package: true,
            ));
          }
        }
      },
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _initial_url != null
            ? WebViewWidget(
                controller: _webViewController,
              )
            : const Center(child: Text("loading...")),
      ),
    );
  }
}

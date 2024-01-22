// import 'dart:convert';
//
// import 'package:active_matrimonial_flutter_app/const/const.dart';
// import 'package:active_matrimonial_flutter_app/const/style.dart';
// import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
// import 'package:active_matrimonial_flutter_app/repository/payment_repository.dart';
// import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
// import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class InstamojoScreen extends StatefulWidget {
//   String amount;
//   String payment_type;
//   String payment_method_key;
//
//   InstamojoScreen(
//       {Key key, this.amount, this.payment_type, this.payment_method_key})
//       : super(key: key);
//
//   @override
//   State<InstamojoScreen> createState() => _InstamojoScreenState();
// }
//
// class _InstamojoScreenState extends State<InstamojoScreen> {
//   WebViewController _webViewController;
//   dynamic _initial_url;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSetInitialUrl();
//   }
//
//   var accessToken = prefs.getString(Const.accessToken);
//
//   getSetInitialUrl() async {
//     Map paypalUrlResponse = await PaymentRepository().getPaypalUrlResponse(
//         amount: widget.amount, payment_method: widget.payment_method_key);
//
//     if (paypalUrlResponse.keys.toList()[0] == false) {
//       MyScaffoldMessenger()
//           .sf_messenger(text: paypalUrlResponse.keys.toList()[2]);
//       Navigator.of(context).pop();
//       return;
//     }
//     paypalUrlResponse.values.toList();
//
//     _initial_url = paypalUrlResponse.values.toList()[1];
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(widget.amount);
//     print(widget.payment_type);
//     print(widget.payment_method_key);
//
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: buildBody(),
//     );
//   }
//
//   void getData() {
//     _webViewController
//         .evaluateJavascript("document.body.innerText")
//         .then((data) {
//       var decodedJSON = jsonDecode(data);
//       Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
//       //print(data.toString());
//       if (responseJSON["result"] == false) {
//         // Toast.show(responseJSON["message"],
//         //     duration: Toast.lengthLong, gravity: Toast.center);
//
//         MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);
//         Navigator.pop(context);
//       } else if (responseJSON["result"] == true) {
//         MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);
//         //  if (widget.payment_type == "wallet_payment") {
//         //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //   //   return MyWallet();
//         //   // }));
//         // }
//
//         // NavigatorPush.push(context: context, page: MyWallet());
//
//         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//           builder: (context) {
//             return MyWallet();
//           },
//         ), (route) => false);
//       }
//     });
//   }
//
//   Widget buildBody() {
//     return SingleChildScrollView(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: _initial_url != null
//             ? WebView(
//                 debuggingEnabled: false,
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onWebViewCreated: (controller) {
//                   _webViewController = controller;
//                   _webViewController.loadUrl(_initial_url, headers: {
//                     "Accept": "application/json",
//                     "Content-Type": "application/json",
//                     "Authorization": "Bearer $accessToken"
//                   });
//                 },
//                 onWebResourceError: (error) {},
//                 onPageFinished: (page) {
//                   if (page.contains("/paypal/payment/done")) {
//                     getData();
//                   } else if (page.contains("/paypal/payment/cancel")) {
//                     // ToastComponent.showDialog("Payment cancelled", gravity: Toast.center, duration: Toast.lengthLong);
//
//                     print("cancel");
//                     Navigator.of(context).pop();
//                     return;
//                   }
//                 },
//               )
//             : Container(
//                 child: Text("loading..."),
//               ),
//       ),
//     );
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         padding: EdgeInsets.zero,
//         constraints: const BoxConstraints(),
//         icon: Image.asset(
//           'assets/icon/icon_pop.png',
//           height: 16,
//           width: 23,
//         ),
//       ),
//       titleSpacing: 0,
//       elevation: 0.0,
//       backgroundColor: Colors.white,
//       iconTheme: IconThemeData(color: Colors.black),
//       title: Text(
//         AppLocalizations.of(context).paypal_screen_title,
//         style: Styles.bold_app_accent_16,
//       ),
//     );
//   }
// }

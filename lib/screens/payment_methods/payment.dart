import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/paypal_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/stripe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import '../../components/common_app_bar.dart';
import '../../components/common_offline_payment.dart';
import '../../components/payment_card.dart';
import '../../redux/libs/package/package_middlewares.dart';
import 'paytm_screen.dart';

class Payment extends StatefulWidget {
  double? amount;
  @required
  String payment_type;
  var package_id;
  String title;

  Payment({
    Key? key,
    this.amount = 0.00,
    this.title = "",
    this.payment_type = "",
    this.package_id = "0",
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _amount_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textFieldHeight = false;

  onPressPlaceOrderOrProceed(AppState state, {var package_id, var index}) {
    if (store.state.paymentTypesState!.selected_payment_method_key ==
        "paypal") {
      NavigatorPush.push(
          context,
          PaypalScreen(
            amount: widget.payment_type == "wallet_payment"
                ? _amount_controller.text
                : widget.amount.toString(),
            payment_type: widget.payment_type,
            payment_method_key:
                state.paymentTypesState!.selected_payment_method_key,
            package_id: package_id.toString(),
          ));
    }
    if (store.state.paymentTypesState!.selected_payment_method_key ==
        "stripe") {
      NavigatorPush.push(
          context,
          StripeScreen(
            amount: widget.payment_type == "wallet_payment"
                ? _amount_controller.text
                : widget.amount,
            payment_type: widget.payment_type,
            payment_method_key:
                state.paymentTypesState!.selected_payment_method_key,
            package_id: package_id.toString(),
          ));
    }
    if (store.state.paymentTypesState!.selected_payment_method_key == "paytm") {
      NavigatorPush.push(
          context,
          PaytmScreen(
            amount: widget.payment_type == "wallet_payment"
                ? _amount_controller.text
                : widget.amount,
            payment_type: widget.payment_type,
            payment_method_key:
                state.paymentTypesState!.selected_payment_method_key,
            package_id: package_id.toString(),
          ));
    }
    if (store.state.paymentTypesState!.selected_payment_method_key ==
        "wallet") {
      pleaseWaitDialog();
      store.dispatch(packagePurchaseMiddleware(
          amount: widget.amount,
          packageId: package_id,
          paymentMethod:
              store.state.paymentTypesState!.selected_payment_method_key));
    }

    if (store.state.paymentTypesState!.selected_payment_type ==
        "manual_payment") {
      NavigatorPush.push(
          context,
          CommonOfflinePayment(
            amount: widget.payment_type == "wallet_payment"
                ? _amount_controller.text
                : widget.amount,
            payment_type: widget.payment_type,
            payment_method_key:
                state.paymentTypesState!.selected_payment_method_key,
            package_id: package_id.toString(),
            details: index.details,
            manual_payment_id: state.paymentTypesState!
                .selected_payment_method_index.manualPaymentId,
            title: state.paymentTypesState!.selected_payment_method_index.title,
          ));
    }
  }

  @override
  void dispose() {
    _amount_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.paymentTypes),
        store.dispatch(paymentTypesMiddleware()),
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            store.dispatch(
              AddPaymentMethodKeyAction(
                method: widget.payment_type,
                key: store
                    .state.paymentTypesState!.paymentTypes![0].paymentTypeKey,
              ),
            );
          },
        )
      ],
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(text: widget.title).build(context),
        body: buildBody(context, state),
        bottomNavigationBar: buildBottomAppBar(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return state.paymentTypesState!.isFetching!
        ? CommonWidget.circularIndicator
        : Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.payment_type == "wallet_payment"
                        ? state.paymentTypesState!.paymentTypes!.length - 1
                        : state.paymentTypesState!.paymentTypes!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PaymentCard(
                        index: index,
                        paymentType: widget.payment_type,
                        image:
                            state.paymentTypesState!.paymentTypes![index].image,
                        title:
                            state.paymentTypesState!.paymentTypes![index].title,
                      );
                    },
                  ),
                ),
              ),
              widget.payment_type == "wallet_payment"
                  ? buildAmount()
                  : Container()
            ],
          );
  }

  BottomAppBar buildBottomAppBar(BuildContext context, AppState state) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TextButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (widget.payment_type == 'wallet_payment') {
                    if (!_formKey.currentState!.validate()) {
                      // store.dispatch(
                      //     ShowMessageAction(msg: "Form's not validated!"));
                    } else {
                      onPressPlaceOrderOrProceed(
                        state,
                        // package_id: widget.package_id,
                        index: state
                            .paymentTypesState!.selected_payment_method_index,
                      );
                      _amount_controller.clear();
                    }
                  } else {
                    onPressPlaceOrderOrProceed(
                      state,
                      package_id: widget.package_id,
                      index: state
                          .paymentTypesState!.selected_payment_method_index,
                    );
                    // _amount_controller.clear();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.app_accent_color),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: MyTheme.app_accent_color)),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.common_confirm,
                  style: Styles.medium_white_16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmount() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: textFieldHeight == true ? 75 : 51,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    setState(() {
                      textFieldHeight = true;
                    });
                    return "Required Field";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _amount_controller,
                decoration:
                    InputStyle.inputDecoration_text_field(hint: "Amount"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pleaseWaitDialog() {
    return OneContext().showDialog<void>(
      builder: (BuildContext context) {
        store.state.packagePaymentWithWalletState!.loadingContext = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.circularIndicator,
              const Text(
                'Please Wait',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}

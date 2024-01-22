import 'package:flutter/material.dart';

import '../const/my_theme.dart';
import '../const/style.dart';
import '../main.dart';
import '../redux/libs/payment_types/payment_types_action.dart';
import 'common_widget.dart';

class PaymentCard extends StatelessWidget {
  final int? index;
  final String? paymentType;
  final String? image;
  final String? title;

  const PaymentCard({
    Key? key,
    this.index,
    this.paymentType,
    this.image,
    this.title,
  }) : super(key: key);

  onPaymentMethodItemTap(index) {
    if (store.state.paymentTypesState!.selected_payment_method !=
        store.state.paymentTypesState!.paymentTypes![index].paymentType) {
      store.dispatch(
        UpdatePaymentMethodKeyAction(
            index: store.state.paymentTypesState!.paymentTypes![index],
            method: paymentType,
            key: store
                .state.paymentTypesState!.paymentTypes![index].paymentTypeKey,
            type: store
                .state.paymentTypesState!.paymentTypes![index].paymentType),
      );
    }
  }

  Widget buildPaymentMethodCheckContainer(bool check) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: check ? 1 : 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.green),
        child: const Padding(
          padding: EdgeInsets.all(3),
          child: Icon(Icons.check, color: Colors.white, size: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPaymentMethodItemTap(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 100,
              decoration: BoxDecoration(
                  color: MyTheme.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [CommonWidget.box_shadow()]),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        image ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                          child: Text(
                            title!,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Styles.medium_gull_grey_14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: buildPaymentMethodCheckContainer(
                store.state.paymentTypesState!.selected_payment_method_key ==
                    store.state.paymentTypesState!.paymentTypes![index!]
                        .paymentTypeKey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

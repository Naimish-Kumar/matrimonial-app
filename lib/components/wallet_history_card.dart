import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const/style.dart';
import 'common_widget.dart';

class WalletHistoryCard extends StatelessWidget {
  final String? date;
  final String? amount;
  final String? paymentMethod;
  final String? approval;

  const WalletHistoryCard({
    Key? key,
    this.date,
    this.amount,
    this.paymentMethod,
    this.approval,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      /// box decoration
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()]),
      // child0
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 14, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNameDateRow(
                name: AppLocalizations.of(context)!.wallet_screen_date,
                data: date!),
            const SizedBox(
              height: 5,
            ),
            buildNameDateRow(
                name: AppLocalizations.of(context)!.wallet_screen_amount,
                data: amount!),
            const SizedBox(
              height: 5,
            ),
            buildNameDateRow(
                name: AppLocalizations.of(context)!.wallet_screen_details,
                data: paymentMethod!),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.wallet_screen_status,
                  style: Styles.regular_arsenic_12,
                )),
                Expanded(
                  child: Text(
                    approval!,
                    style: approval != 'Approved'
                        ? Styles.bold_gull_grey_12
                        : Styles.bold_green_12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildNameDateRow({required var name, required var data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          name,
          style: Styles.regular_arsenic_12,
        )),
        Expanded(
          child: Text(
            data,
            style: Styles.bold_arsenic_12,
          ),
        )
      ],
    );
  }
}

import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_PermanentAddress extends StatelessWidget {
  const PP_PermanentAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.permanentaddress !=
              null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_city,
                    data: state.publicProfileState!.permanentaddress.city ?? ""),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_state,
                    data:
                        "${state.publicProfileState!.permanentaddress.state ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_country,
                    data:
                        "${state.publicProfileState!.permanentaddress.country ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_postal_code,
                    data:
                        "${state.publicProfileState!.permanentaddress.postalCode ?? ''}"),
              ],
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            ),
    );
  }

  Row buildRow({BuildContext? context, required localization_text, required data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(localization_text, style: Styles.regular_gull_grey_12)),
        Expanded(child: Text(data))
      ],
    );
  }
}

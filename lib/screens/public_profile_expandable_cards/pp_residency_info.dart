import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_ResidencyInfo extends StatelessWidget {
  const PP_ResidencyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) =>
          state.publicProfileState!.resi !=
                  null
              ? Column(
                  children: [
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_birth_country,
                        data: state.publicProfileState!.resi.birthCountry ??
                            ''),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_growup_country,
                        data:
                            "${state.publicProfileState!.resi.growupCountry ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_residency_country,
                        data:
                            "${state.publicProfileState!.resi.recidencyCountry ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_immigration_status,
                        data:
                            "${state.publicProfileState!.resi.immigrationStatus ?? ''}"),
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

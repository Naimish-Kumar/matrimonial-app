import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_LifeStyle extends StatelessWidget {
  const PP_LifeStyle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) =>
          state.publicProfileState!.lifestyle != null
              ? Column(
                  children: [
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_diet,
                        data:
                            "${state.publicProfileState!.lifestyle.diet ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_smoke,
                        data:
                            "${state.publicProfileState!.lifestyle.smoke ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_drink,
                        data:
                            "${state.publicProfileState!.lifestyle.drink ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_living_with,
                        data:
                            "${state.publicProfileState!.lifestyle.livingWith ?? ''}"),
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

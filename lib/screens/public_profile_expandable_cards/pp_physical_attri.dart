import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_PhysicalAttributes extends StatelessWidget {
  const PP_PhysicalAttributes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.physical !=
              null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_height,
                    data:
                        "${state.publicProfileState!.physical.height ?? ''} ft"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_eye_color,
                    data:
                        "${state.publicProfileState!.physical.eyeColor ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_complexion,
                    data:
                        "${state.publicProfileState!.physical.complexion ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_body_type,
                    data:
                        "${state.publicProfileState!.physical.bodyType ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_disability,
                    data:
                        "${state.publicProfileState!.physical.disability ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_weight,
                    data:
                        "${state.publicProfileState!.physical.weight ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_hair_color,
                    data:
                        "${state.publicProfileState!.physical.hairColor ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_blood_group,
                    data:
                        "${state.publicProfileState!.physical.bloodGroup ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_body_art,
                    data:
                        "${state.publicProfileState!.physical.bodyArt ?? ''}"),
                SizedBox(
                  height: 10,
                ),
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

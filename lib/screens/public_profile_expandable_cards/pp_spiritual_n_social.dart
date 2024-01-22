import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_SpiritualSocial extends StatelessWidget {
  const PP_SpiritualSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.spiritual !=
              null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_religion,
                    data:
                        "${state.publicProfileState!.spiritual.religionId ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_sub_caste,
                    data:
                        "${state.publicProfileState!.spiritual.subCasteId ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_personal_value,
                    data:
                        "${state.publicProfileState!.spiritual.personalValue ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_community_val,
                    data:
                        "${state.publicProfileState!.spiritual.communityValue ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_caste,
                    data:
                        "${state.publicProfileState!.spiritual.casteId ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_ethnicity,
                    data:
                        "${state.publicProfileState!.spiritual.ethnicity ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_family_value,
                    data:
                        "${state.publicProfileState!.spiritual.familyValueId ?? ''}"),
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

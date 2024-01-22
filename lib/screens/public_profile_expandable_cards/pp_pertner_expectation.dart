import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PP_PartnerExpectation extends StatelessWidget {
  const PP_PartnerExpectation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.partner != null
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: Column(
                  children: [
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_general,
                        data: state.publicProfileState!.partner.general),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_residency_country,
                        data: state
                            .publicProfileState!.partner.residenceCountryId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_height,
                        data:
                            "${state.publicProfileState!.partner.height.toString() ?? ''} ft"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_weight,
                        data:
                            "${state.publicProfileState!.partner.weight.toString() ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_religion,
                        data: state.publicProfileState!.partner.religionId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_caste,
                        data: state.publicProfileState!.partner.casteId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_sub_caste,
                        data: state.publicProfileState!.partner.subCasteId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_marital_status,
                        data:
                            "${state.publicProfileState!.partner.maritalStatus ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_children_acceptable,
                        data: state
                            .publicProfileState!.partner.childrenAcceptable),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_Lang,
                        data:
                            "${state.publicProfileState!.partner.language ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_education,
                        data:
                            "${state.publicProfileState!.partner.education ?? ""}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_profession,
                        data:
                            "${state.publicProfileState!.partner.profession ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_smoking_acceptable,
                        data:
                            state.publicProfileState!.partner.smokingAcceptable),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_drinking_acceptable,
                        data: state
                            .publicProfileState!.partner.drinkingAcceptable),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_diet,
                        data: "${state.publicProfileState!.partner.diet ?? ""}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_body_type,
                        data:
                            "${state.publicProfileState!.partner.bodyType ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_personal_value,
                        data:
                            "${state.publicProfileState!.partner.personalValue ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.manage_profile_manglik,
                        data:
                            "${state.publicProfileState!.partner.manglik ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_preferred_country,
                        data: state
                            .publicProfileState!.partner.preferredCountryId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_preferred_state,
                        data:
                            state.publicProfileState!.partner.preferredStateId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .manage_profile_family_value,
                        data: state.publicProfileState!.partner.familyValueId),
                    const SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_complexion,
                        data:
                            "${state.publicProfileState!.partner.complexion ?? ''}"),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data,
                  style: TextStyle(height: 10)),
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

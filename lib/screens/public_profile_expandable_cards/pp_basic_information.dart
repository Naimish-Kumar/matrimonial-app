import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class PP_BasicInformation extends StatelessWidget {
  const PP_BasicInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.basic != null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_name,
                    data: state.publicProfileState!.basic.firsName + ""),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_religion,
                    data: state.publicProfileState!.basic.religion),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: "Caste",
                    data: state.publicProfileState!.basic.caste),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_age,
                    data: "${state.publicProfileState!.basic.age}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: "Gender",
                    data: "${state.publicProfileState!.basic.gender}"),
                // SizedBox(
                //   height: 10,
                // ),
                // buildRow(
                //     context: context,
                //     localization_text: AppLocalizations.of(context)
                //         .public_profile_first_lang,
                //     data: state.publicProfileState.publicProfileResponse
                //             .data.basicInfo.firstLanguage ??
                //         ''),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_children,
                    data: state.publicProfileState!.basic.noOfChildren
                        .toString()),
                // SizedBox(
                //   height: 10,
                // ),
                // buildRow(
                //     context: context,
                //     localization_text:
                //         AppLocalizations.of(context).public_profile_height,
                //     data:
                //         """${state.publicProfileState.publicProfileResponse.data.basicInfo.height ?? ''} ft"""),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                  context: context,
                  localization_text:
                      AppLocalizations.of(context)!.public_profile_dob,
                  data: DateFormat("y-MM-dd")
                      .format((state.publicProfileState!.basic.dateOfBirth)),
                ),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .public_profile_marital_status,
                    data:
                        "${state.publicProfileState!.basic.maritialStatus ?? ''}"),
              ],
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            ),
    );
  }

  Row buildRow(
      {BuildContext? context, required localization_text, required data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          localization_text,
          style: Styles.regular_gull_grey_12,
        )),
        Expanded(child: Text(data))
      ],
    );
  }
}

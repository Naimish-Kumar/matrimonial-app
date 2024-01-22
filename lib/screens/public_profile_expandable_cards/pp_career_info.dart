import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_CareerInfo extends StatelessWidget {
  const PP_CareerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.career.isNotEmpty
          ? ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
              shrinkWrap: true,
              reverse: true,
              itemCount: state.publicProfileState!.career.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_designation,
                        data: state.publicProfileState!.career[index].designation ??
                            ''),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_company,
                        data: state.publicProfileState!.career[index].company ??
                            ''),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_start,
                        data:
                            "${state.publicProfileState!.career[index].start ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_end,
                        data:
                            "${state.publicProfileState!.career[index].end ?? ''}"),

                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                        "Status",
                        data:
                        "${state.publicProfileState!.career[index].present? "Active": "Deactive"}"),
                  ],
                );
              },
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

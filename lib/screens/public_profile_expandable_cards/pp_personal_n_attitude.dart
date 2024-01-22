import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_PersonalAttitude extends StatelessWidget {
  const PP_PersonalAttitude({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) =>
          state.publicProfileState!.attitude != null
              ? Column(
                  children: [
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_affection,
                        data:
                            "${state.publicProfileState!.attitude.affection ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_political_view,
                        data:
                            "${state.publicProfileState!.attitude.politicalViews ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text:
                            AppLocalizations.of(context)!.public_profile_humor,
                        data:
                            "${state.publicProfileState!.attitude.humor ?? ''}"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRow(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .public_profile_religious_service,
                        data:
                            "${state.publicProfileState!.attitude.religiousService ?? ''}"),
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

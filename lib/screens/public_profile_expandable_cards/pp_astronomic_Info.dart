import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PP_AstronomicInfo extends StatelessWidget {
  const PP_AstronomicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state
                  .publicProfileState!.astrologies !=
              null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_sun_sign,
                    data:
                        "${state
                            .publicProfileState!.astrologies.sunSign ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_moon_sign,
                    data:
                        "${state
                            .publicProfileState!.astrologies.moonSign ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_time_of_birth,
                    data:
                        "${state
                            .publicProfileState!.astrologies.timeOfBirth ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_city_of_birth,
                    data:
                        "${state
                            .publicProfileState!.astrologies.cityOfBirth ?? ''}"),
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

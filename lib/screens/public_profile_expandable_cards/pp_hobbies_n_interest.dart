import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';

class PP_HobbiesInterest extends StatelessWidget {
  const PP_HobbiesInterest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.hobbies !=
              null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_hobbies,
                    data:
                        "${state.publicProfileState!.hobbies.hobbies ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_music,
                    data:
                        "${state.publicProfileState!.hobbies.music ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_movies,
                    data:
                        "${state.publicProfileState!.hobbies.movies ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_sports,
                    data:
                        "${state.publicProfileState!.hobbies.sports ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_cuisines,
                    data:
                        "${state.publicProfileState!.hobbies.cuisines ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_interests,
                    data:
                        "${state.publicProfileState!.hobbies.interests ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_books,
                    data:
                        "${state.publicProfileState!.hobbies.books ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_tv_shows,
                    data:
                        "${state.publicProfileState!.hobbies.tvShows ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_fitness_activities,
                    data:
                        "${state.publicProfileState!.hobbies.fitnessActivities ?? ''}"),
                SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_dress_styles,
                    data:
                        "${state.publicProfileState!.hobbies.dressStyles ?? ''}"),
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

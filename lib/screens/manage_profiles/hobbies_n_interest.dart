import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HobbiesInterest extends StatefulWidget {
  const HobbiesInterest({Key? key}) : super(key: key);

  @override
  State<HobbiesInterest> createState() => _HobbiesInterestState();
}

class _HobbiesInterestState extends State<HobbiesInterest> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_hobbies_n_interest,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: SingleChildScrollView(
              child: Form(
                key: state
                    .manageProfileCombineState!.hobbiesInterestState!.formKey,
                child: buildBody(context, state),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_your_hobbies_n_interest,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_hobbies,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .hobbiesController,
          hint: "Hobbies",
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
            text: AppLocalizations.of(context)!.manage_profile_interests,
            style: Styles.bold_arsenic_12,
            controller: state.manageProfileCombineState!.hobbiesInterestState!
                .interestsController,
            hint: "Interests"),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_music,
          style: Styles.bold_arsenic_12,
          hint: "Music",
          controller: state
              .manageProfileCombineState!.hobbiesInterestState!.musicController,
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_books,
          style: Styles.bold_arsenic_12,
          hint: "Books ",
          controller: state
              .manageProfileCombineState!.hobbiesInterestState!.booksController,
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_movies,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .moviesController,
          hint: "Movies",
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_tv_shows,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .tvShowController,
          hint: "Tv Shows",
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_sports,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .sportsController,
          hint: "Sports",
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_fitness_activities,
          hint: "Fitness Activities",
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .fitnessActivitiesController,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_cuisines,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .cuisinesController,
          hint: "Cuisines",
        ),
        const SizedBox(
          height: 20,
        ),
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_dress_styles,
          style: Styles.bold_arsenic_12,
          hint: "Dress Styles",
          controller: state.manageProfileCombineState!.hobbiesInterestState!
              .dressStylesController,
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.hobbiesInterest),
          child: Container(
            height: 45,
            width: DeviceInfo(context).width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(0.8, 1),
                colors: [
                  MyTheme.gradient_color_1,
                  MyTheme.gradient_color_2,
                ],
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: Center(
              child: state.manageProfileCombineState!.hobbiesInterestState!
                          .isLoading ==
                      false
                  ? Text(
                      AppLocalizations.of(context)!.save_change_btn_text,
                      style: Styles.bold_white_14,
                    )
                  : CommonWidget.circularIndicator,
            ),
          ),
        ),
      ],
    );
  }
}

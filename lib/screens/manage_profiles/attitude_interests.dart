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

class PersonalAttitude extends StatefulWidget {
  const PersonalAttitude({Key? key}) : super(key: key);
  @override
  State<PersonalAttitude> createState() => _PersonalAttitudeState();
}

class _PersonalAttitudeState extends State<PersonalAttitude> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!
              .public_profile_personal_attri_behavior,
        ).build(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal,
                  vertical: Const.kPaddingVertical),
              child: Column(
                children: [
                  Form(
                    key: state.manageProfileCombineState!
                        .attributeBehaviorState!.formKey,
                    child: Column(
                      children: [
                        buildBody(context, state),
                      ],
                    ),
                  )
                ],
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
          AppLocalizations.of(context)!
              .public_profile_your_personal_attri_behavior,
          style: Styles.bold_app_accent_14,
        ),
        Const.height25,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.public_profile_affection,
          hint: "Tender Attachment",
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.attributeBehaviorState!
              .affectionController,
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.public_profile_humor,
          hint: "Incongruity, Slapstick",
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.attributeBehaviorState!
              .humorController,
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.public_profile_religious_service,
          hint: "Interested",
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.attributeBehaviorState!
              .religiousServiceController,
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.public_profile_political_view,
          hint: "Not Interested",
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.attributeBehaviorState!
              .politicalViewsController,
        ),
        Const.height20,
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.attitudeBehaviour),
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
              child: state.manageProfileCombineState!.attributeBehaviorState!
                          .isLoading ==
                      false
                  ? Text(
                      AppLocalizations.of(context)!.save_change_btn_text,
                      style: Styles.bold_white_14,
                    )
                  : CommonWidget.circularIndicator,
            ),
          ),
        )
      ],
    );
  }
}

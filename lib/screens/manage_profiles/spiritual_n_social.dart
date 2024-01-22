import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/sub_caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/spiritual_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class SpiritualSocial extends StatefulWidget {
  const SpiritualSocial({Key? key}) : super(key: key);

  @override
  State<SpiritualSocial> createState() => _SpiritualSocialState();
}

class _SpiritualSocialState extends State<SpiritualSocial> {
  final _formKey = GlobalKey<FormState>();

  // var family_value;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) {
        if (store.state.manageProfileCombineState!.spiritualSocialState!
            .spiritualSocialGetResponse!.result!) {
          store.state.manageProfileCombineState?.spiritualSocialState
              ?.ethnicityController.text = store
                  .state
                  .manageProfileCombineState
                  ?.spiritualSocialState
                  ?.spiritualSocialGetResponse
                  ?.data
                  ?.ethnicity ??
              "";
          store.state.manageProfileCombineState!.spiritualSocialState!
              .personalController.text = store
                  .state
                  .manageProfileCombineState!
                  .spiritualSocialState!
                  .spiritualSocialGetResponse!
                  .data!
                  .personalValue ??
              "";
          store.state.manageProfileCombineState!.spiritualSocialState!
              .communityController.text = store
                  .state
                  .manageProfileCombineState!
                  .spiritualSocialState!
                  .spiritualSocialGetResponse!
                  .data!
                  .communityValue ??
              "";

          store.state.manageProfileCombineState!.profiledropdownResponseData!
              .data!.religionList!
              .forEach((element) {
            if (element.name.toString() ==
                store.state.manageProfileCombineState!.spiritualSocialState!
                    .spiritualSocialGetResponse!.data!.religionId
                    .toString()) {
              store.state.manageProfileCombineState!.spiritualSocialState!
                  .religion_val = element;

              if (store.state.manageProfileCombineState!.spiritualSocialState!
                  .casteResponse!.data!.isNotEmpty) {
                store.dispatch(EmptyCasteAction());
              }
              if (store.state.manageProfileCombineState!.spiritualSocialState!
                  .subcasteResponse!.data!.isNotEmpty) {
                store.dispatch(EmptySubCasteAction());
              }
            }
          });

          store.dispatch(casteMiddleware(store.state.manageProfileCombineState!
              .spiritualSocialState!.religion_val!.id));
          store.state.manageProfileCombineState!.profiledropdownResponseData!
              .data!.familyValueList!
              .forEach((element) {
            if (element.name ==
                store.state.manageProfileCombineState!.spiritualSocialState!
                    .spiritualSocialGetResponse!.data!.familyValueId) {
              store.state.manageProfileCombineState!.spiritualSocialState!
                  .family_val = element;
            }
          });
        }
      },
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_spiritual_n_social,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: SingleChildScrollView(
              child: Form(key: _formKey, child: build_body(context, state)),
            ),
          ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_religion(context, state),
          build_caste(context, state),
          build_sub_caste(context, state),
          build_ethnicity(context, state),
          build_personal_value(context, state),
          build_family_value(context, state),
          build_community_value(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
              } else {
                store.dispatch(spiritualSocialUpdateMiddleware(
                    religion: state.manageProfileCombineState!
                            .spiritualSocialState!.religion_val?.id ??
                        0,
                    caste: state.manageProfileCombineState!
                            .spiritualSocialState!.caste_val?.id ??
                        0,
                    sub_caste: state.manageProfileCombineState!
                            .spiritualSocialState!.sub_caste_val?.id ??
                        0,
                    ethnicity: state.manageProfileCombineState!
                        .spiritualSocialState!.ethnicityController.text,
                    personal_value: state.manageProfileCombineState!
                        .spiritualSocialState!.personalController.text,
                    family_value: state.manageProfileCombineState!
                        .spiritualSocialState!.family_val?.id,
                    community_value: state.manageProfileCombineState!
                        .spiritualSocialState!.communityController.text));
              }
            },
            child: Container(
              height: 45,
              width: DeviceInfo(context).width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [
                    MyTheme.gradient_color_1,
                    MyTheme.gradient_color_2,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: Center(
                child: state.manageProfileCombineState!.spiritualSocialState!
                            .spSaveChanges ==
                        false
                    ? Text(
                        AppLocalizations.of(context)!.save_change_btn_text,
                        style: Styles.bold_white_14,
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  build_religion(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_religion,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CommonWidget().buildCommonDropDown(
            state.manageProfileCombineState!.profiledropdownResponseData!.data!
                .religionList!,
            state.manageProfileCombineState!.spiritualSocialState!.religion_val,
            (DDown selectedValue) {
              //  state.manageProfileCombineState.spiritualSocialState.religion_val=selectedValue;
              store.dispatch(AddReligionValueAction(value: selectedValue));

              if (state.manageProfileCombineState!.spiritualSocialState!
                  .casteResponse!.data!.isNotEmpty) {
                store.dispatch(EmptyCasteAction());
              }
              if (state.manageProfileCombineState!.spiritualSocialState!
                  .subcasteResponse!.data!.isNotEmpty) {
                store.dispatch(EmptySubCasteAction());
              }
              store.dispatch(casteMiddleware(selectedValue.id));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_caste(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_caste,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<DDown>(
            isExpanded: true,
            iconSize: 0.0,
            value: state
                .manageProfileCombineState!.spiritualSocialState!.caste_val,
            decoration: InputDecoration(
              hintText: "Select One",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: MyTheme.gull_grey,
              ),
              // helperText: 'Helper text',
            ),
            items: state.manageProfileCombineState!.spiritualSocialState!
                .casteResponse!.data!
                .map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name!,
                  style: Styles.regular_gull_grey_12
                      .copyWith(color: MyTheme.black),
                ),
              );
            }).toList(),
            onChanged: (DDown? newValue) {
              store.dispatch(AddCasteValueAction(value: newValue));

              if (state.manageProfileCombineState!.spiritualSocialState!
                  .subcasteResponse!.data!.isNotEmpty) {
                store.dispatch(EmptySubCasteAction());
              }
              store.dispatch(subcasteMiddleware(newValue!.id));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_sub_caste(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // gender and date of birth
        Text(
          AppLocalizations.of(context)!.manage_profile_sub_caste,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<DDown>(
            isExpanded: true,
            iconSize: 0.0,
            value: state
                .manageProfileCombineState!.spiritualSocialState!.sub_caste_val,
            decoration: InputDecoration(
              hintText: "Select One",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: MyTheme.gull_grey,
              ),
              // helperText: 'Helper text',
            ),
            items: state.manageProfileCombineState!.spiritualSocialState!
                .subcasteResponse!.data!
                .map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name!,
                  style: Styles.regular_gull_grey_12
                      .copyWith(color: MyTheme.black),
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              store.dispatch(AddSubCasteValueAction(value: newValue));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_ethnicity(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // gender and date of birth
        Text(
          AppLocalizations.of(context)!.manage_profile_ethnicity,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: state.manageProfileCombineState!.spiritualSocialState!
              .ethnicityController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Ethnicity "),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_personal_value(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_personal_val,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: state.manageProfileCombineState!.spiritualSocialState!
              .personalController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Personal Value"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_family_value(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_family_val,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<DDown>(
            isExpanded: true,
            iconSize: 0.0,
            value: state
                .manageProfileCombineState!.spiritualSocialState!.family_val,
            decoration: InputDecoration(
              hintText: "Select One",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: MyTheme.gull_grey,
              ),
              // helperText: 'Helper text',
            ),
            items: state.manageProfileCombineState!.profiledropdownResponseData!
                .data!.familyValueList!
                .map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name!,
                  style: Styles.regular_gull_grey_12
                      .copyWith(color: MyTheme.black),
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              store.dispatch(AddFamilyValueAction(value: newValue));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_community_value(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.manage_profile_community_val,
            style: Styles.bold_arsenic_12),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: state.manageProfileCombineState!.spiritualSocialState!
              .communityController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Community Value"),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

build_title(BuildContext context, AppState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.of(context)!.public_profile_your_spiritual_n_social,
        style: Styles.bold_app_accent_14,
      ),
      const SizedBox(
        height: 25,
      ),
    ],
  );
}

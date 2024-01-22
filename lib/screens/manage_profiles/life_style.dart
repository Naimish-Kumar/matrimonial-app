import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class LifeStyle extends StatefulWidget {
  const LifeStyle({Key? key}) : super(key: key);

  @override
  State<LifeStyle> createState() => _LifeStyleState();
}

class _LifeStyleState extends State<LifeStyle> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) {
        if (store.state.manageProfileCombineState!.lifeStyleState!
                    .lifeStyleGetResponse!.result !=
                null &&
            store.state.manageProfileCombineState!.lifeStyleState!
                .lifeStyleGetResponse!.result!) {
          store.state.manageProfileCombineState!.lifeStyleState!
              .living_withController.text = (store
                  .state
                  .manageProfileCombineState
                  ?.lifeStyleState
                  ?.lifeStyleGetResponse
                  ?.data
                  ?.livingWith) ??
              "";

          store.state.manageProfileCombineState!.lifeStyleState!.diet_value =
              store.state.manageProfileCombineState!.lifeStyleState!
                  .lifeStyleGetResponse!.data!.diet;
          store.state.manageProfileCombineState!.lifeStyleState!.drink_value =
              store.state.manageProfileCombineState!.lifeStyleState!
                  .lifeStyleGetResponse!.data!.drink;
          store.state.manageProfileCombineState!.lifeStyleState!.smoke_value =
              store.state.manageProfileCombineState!.lifeStyleState!
                  .lifeStyleGetResponse!.data!.smoke;
        }
      },
      builder: (_, state) => state
                  .manageProfileCombineState!.lifeStyleState!.isLoading ==
              false
          ? Scaffold(
              appBar: CommonAppBarManageProfile(
                text: AppLocalizations.of(context)!.public_profile_life_style,
              ).build(context),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal,
                      vertical: Const.kPaddingVertical),
                  child: SingleChildScrollView(
                    child:
                        Form(key: _formKey, child: build_body(context, state)),
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: MyTheme.storm_grey,
              ),
            ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_your_life_style,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  build_diet(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_diet,
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
          child: DropdownButtonFormField(
              validator: (dynamic val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
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
              value: store
                  .state.manageProfileCombineState!.lifeStyleState!.diet_value,
              items: store
                  .state.manageProfileCombineState!.lifeStyleState!.items
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    capitalize(e),
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState!.lifeStyleState!
                      .diet_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_drink(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_drink,
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
          child: DropdownButtonFormField(
              validator: (dynamic val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
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
              value: store
                  .state.manageProfileCombineState!.lifeStyleState!.drink_value,
              items: store
                  .state.manageProfileCombineState!.lifeStyleState!.items
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    capitalize(e),
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState!.lifeStyleState!
                      .drink_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_smoke(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_smoke,
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
          child: DropdownButtonFormField(
              validator: (dynamic val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
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
              value: store
                  .state.manageProfileCombineState!.lifeStyleState!.smoke_value,
              items: store
                  .state.manageProfileCombineState!.lifeStyleState!.items
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    capitalize(e),
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState!.lifeStyleState!
                      .smoke_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_living_with(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_living_with,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: state
              .manageProfileCombineState!.lifeStyleState!.living_withController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Parents"),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_diet(context, state),
          build_drink(context, state),
          build_smoke(context, state),
          build_living_with(context, state),
          InkWell(
            onTap: () {
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
              } else {
                store.state.manageProfileCombineState!.lifeStyleState!
                            .diet_value ==
                        "yes"
                    ? 1
                    : 2;
                store.state.manageProfileCombineState!.lifeStyleState!
                            .drink_value ==
                        "yes"
                    ? 1
                    : 2;
                store.state.manageProfileCombineState!.lifeStyleState!
                            .smoke_value ==
                        "yes"
                    ? 1
                    : 2;

                store.dispatch(life_style_update_Middleware(
                    diet: store.state.manageProfileCombineState!.lifeStyleState!
                        .diet_value,
                    drink: store.state.manageProfileCombineState!
                        .lifeStyleState!.drink_value,
                    smoke: store.state.manageProfileCombineState!
                        .lifeStyleState!.smoke_value,
                    living_with: state.manageProfileCombineState!
                        .lifeStyleState!.living_withController.text));
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
                child: state.manageProfileCombineState!.lifeStyleState!
                            .saveChanges ==
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
          )
        ],
      ),
    );
  }
}

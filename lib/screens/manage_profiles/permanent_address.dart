import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/city_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/drop_down/state_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class PermanentAddress extends StatefulWidget {
  const PermanentAddress({Key? key}) : super(key: key);

  @override
  State<PermanentAddress> createState() => _PermanentAddressState();
}

class _PermanentAddressState extends State<PermanentAddress> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      onInit: (store) {
        if (store.state.manageProfileCombineState!.permanentAddressState!
                .permanentGetResponse!.result! &&
            store.state.manageProfileCombineState!.profiledropdownResponseData!
                .data!.countryList!.isNotEmpty) {
          store.state.manageProfileCombineState!.profiledropdownResponseData!
              .data!.countryList!
              .forEach((element) {
            if (element.name ==
                store.state.manageProfileCombineState!.permanentAddressState!
                    .permanentGetResponse!.data!.country) {
              store.state.manageProfileCombineState!.permanentAddressState!
                  .selected_country = element;
            }
          });
          store.dispatch(stateMiddleware(
              store.state.manageProfileCombineState!.permanentAddressState!
                  .selected_country!.id,
              state: AppStates.permanentAddress));

          store.state.manageProfileCombineState!.permanentAddressState!
                  .postalCodeController.text =
              store.state.manageProfileCombineState!.permanentAddressState!
                  .permanentGetResponse!.data!.postalCode!;
        }
      },
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_permanent_address,
        ).build(context),
        body: SingleChildScrollView(
          child: state.manageProfileCombineState!.permanentAddressState!
                      .is_loading ==
                  false
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Const.kPaddingHorizontal,
                        vertical: Const.kPaddingVertical),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              build_body(context, state),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
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
          build_country(context, state),
          build_state(context, state),
          build_city(context, state),
          build_postal_code(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(
                //   msg: "Form's not validated!",
                // ));
              } else {
                store.dispatch(permanentAddressUpdateMiddleware(
                    country: state.manageProfileCombineState!
                        .permanentAddressState!.selected_country!.id,
                    state: state.manageProfileCombineState!
                        .permanentAddressState!.selected_state!.id,
                    city: state.manageProfileCombineState!
                        .permanentAddressState!.selected_city?.id,
                    postal_code: state.manageProfileCombineState!
                        .permanentAddressState!.postalCodeController.text));
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
                child: state.manageProfileCombineState!.permanentAddressState!
                            .permanent_address_save_changes ==
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

  build_title(BuildContext context, AppState state) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_permanent_address,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  build_country(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_country,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyTheme.solitude),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<dynamic>(
              isExpanded: true,
              iconSize: 0.0,
              decoration: InputDecoration(
                hintText: "Select one",
                isDense: true,
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: MyTheme.gull_grey,
                ),
              ),
              value: state.manageProfileCombineState!.permanentAddressState!
                  .selected_country,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.countryList!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e.name!,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                state.manageProfileCombineState!.permanentAddressState!
                    .selected_country = newValue;
                if (state.manageProfileCombineState!.permanentAddressState!
                    .stateResponse!.data!.isNotEmpty) {
                  store.dispatch(PEmptyStateValueAction());
                }
                if (state.manageProfileCombineState!.permanentAddressState!
                    .cityResponse!.data!.isNotEmpty) {
                  store.dispatch(PEmptyCityValueAction());
                }
                store.dispatch(stateMiddleware(newValue.id,
                    state: AppStates.permanentAddress));
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_state(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_state,
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
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
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
            value: state.manageProfileCombineState!.permanentAddressState!
                .selected_state,
            items: state.manageProfileCombineState!.permanentAddressState!
                .stateResponse!.data!
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e,
                child: Text(
                  e.name!,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              state.manageProfileCombineState!.permanentAddressState!
                  .selected_state = newValue;
              if (state.manageProfileCombineState!.permanentAddressState!
                  .cityResponse!.data!.isNotEmpty) {
                store.dispatch(PEmptyCityValueAction());
              }
              store.dispatch(cityMiddleware(
                  state.manageProfileCombineState!.permanentAddressState!
                      .selected_state!.id,
                  AppStates.permanentAddress));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_city(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_city,
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
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
            iconSize: 0.0,
            value: state.manageProfileCombineState!.permanentAddressState!
                .selected_city,
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
            items: state.manageProfileCombineState!.permanentAddressState!
                .cityResponse!.data!
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e,
                child: Text(
                  e.name!,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              state.manageProfileCombineState!.permanentAddressState!
                  .selected_city = newValue;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_postal_code(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_postal_code,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
          controller: state.manageProfileCombineState!.permanentAddressState!
              .postalCodeController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Postal Code"),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/city_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/state_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/present_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class PresentAddress extends StatefulWidget {
  const PresentAddress({Key? key}) : super(key: key);

  @override
  State<PresentAddress> createState() => _PresentAddressState();
}

class _PresentAddressState extends State<PresentAddress> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _postal_codeController =
      TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.dispatch(EmptyStateAction());
    store.dispatch(EmptyCityAction());

    _postal_codeController.text = store.state.manageProfileCombineState
            ?.presentAddressState?.presentAddressData?.postalCode ??
        "";

    if (store.state.manageProfileCombineState!.presentAddressState!.result !=
        false) {
      store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
          .countryList!
          .forEach((element) {
        if (element.name ==
            store.state.manageProfileCombineState!.presentAddressState!
                .presentAddressData?.country) {
          store.state.manageProfileCombineState!.presentAddressState!
              .selected_country = element;
          store.dispatch(
              stateMiddleware(element.id, state: AppStates.presentAddress));
        }
      });
    } else {
      if (store.state.manageProfileCombineState!.profiledropdownResponseData!
          .data!.countryList!.isNotEmpty) {
        store.state.manageProfileCombineState!.presentAddressState!
                .selected_country =
            store.state.manageProfileCombineState!.profiledropdownResponseData!
                .data!.countryList!.first;
        store.dispatch(stateMiddleware(
            store.state.manageProfileCombineState!.presentAddressState!
                .selected_country!.id,
            state: AppStates.presentAddress));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_present_address,
        ).build(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal,
                  vertical: Const.kPaddingVertical),
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
          build_country(context, state),
          build_state(context, state),
          build_city(context, state),
          build_postal_code(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
              } else {
                store.dispatch(presentAddressUpdateMiddleware(
                    country: state.manageProfileCombineState
                        ?.presentAddressState?.selected_country?.id,
                    state: state.manageProfileCombineState?.presentAddressState
                        ?.selected_state?.id,
                    city: state.manageProfileCombineState?.presentAddressState
                        ?.selected_city?.id,
                    postal_code: _postal_codeController.text));
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
                child: state.manageProfileCombineState!.presentAddressState!
                            .saveChangesLoader ==
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

  Widget build_country(BuildContext context, AppState state) {
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
            child: DropdownButtonFormField<DDown>(
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
              value: state.manageProfileCombineState!.presentAddressState!
                  .selected_country,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.countryList!
                  .map<DropdownMenuItem<DDown>>((e) {
                return DropdownMenuItem<DDown>(
                  value: e,
                  child: Text(
                    e.name!,
                  ),
                );
              }).toList(),
              onChanged: (DDown? newValue) {
                state.manageProfileCombineState!.presentAddressState!
                    .selected_country = newValue;

                // store.dispatch(AddCountryValueAction(value: newValue.id));
                if (state.manageProfileCombineState!.presentAddressState!
                    .stateResponse!.data!.isNotEmpty) {
                  store.dispatch(EmptyStateAction());
                }
                if (state.manageProfileCombineState!.presentAddressState!
                    .cityResponse!.data!.isNotEmpty) {
                  store.dispatch(EmptyCityAction());
                }

                store.dispatch(stateMiddleware(newValue!.id));
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_state(BuildContext context, AppState state) {
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
          child: DropdownButtonFormField<DDown>(
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
            value: state
                .manageProfileCombineState!.presentAddressState!.selected_state,
            items: state.manageProfileCombineState!.presentAddressState!
                .stateResponse!.data!
                .map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name!,
                ),
              );
            }).toList(),
            onChanged: (DDown? newValue) {
              state.manageProfileCombineState!.presentAddressState!
                  .selected_state = newValue;
              // store.dispatch(AddStateValueAction(value: s_value));

              if (state.manageProfileCombineState!.presentAddressState!
                  .cityResponse!.data!.isNotEmpty) {
                store.dispatch(EmptyCityAction());
              }

              // print(newValue!.id);
              store.dispatch(
                  cityMiddleware(newValue!.id, AppStates.presentAddress));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_city(BuildContext context, AppState state) {
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<DDown>(
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
            value: state
                .manageProfileCombineState!.presentAddressState!.selected_city,
            items: state.manageProfileCombineState!.presentAddressState!
                .cityResponse!.data!
                .map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name!,
                ),
              );
            }).toList(),
            onChanged: (DDown? newValue) {
              state.manageProfileCombineState!.presentAddressState!
                  .selected_city = newValue;
              // print(c_value);

              // store.dispatch(AddCityValueAction(value: c_value));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_postal_code(context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_postal_code,
          controller: _postal_codeController,
          hint: "2200",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_address,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class ResidencyInformation extends StatefulWidget {
  const ResidencyInformation({Key? key}) : super(key: key);

  @override
  State<ResidencyInformation> createState() => _ResidencyInformationState();
}

class _ResidencyInformationState extends State<ResidencyInformation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _immigration_status = TextEditingController(
      text: store.state.manageProfileCombineState!.residencyState!
                  .residencyGetResponse!.data ==
              null
          ? ""
          : store.state.manageProfileCombineState!.residencyState!
              .residencyGetResponse!.data!.immigrationStatus);

  // country
  var country_id;
  var country_value;

//state
  var residency_country_value;
  var residency_country_id;
  var grow_up_country_value;
  var grow_up_country_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (store.state.manageProfileCombineState!.residencyState!
            .residencyGetResponse!.result !=
        false) {
      store.state.manageProfileCombineState!.profiledropdownResponseData!.data!
          .countryList!
          .forEach((element) {
        if (element.name ==
            store.state.manageProfileCombineState!.residencyState!
                .residencyGetResponse!.data!.birthCountry) {
          country_value = element.name;
          country_id = element.id;
        }

        if (element.name ==
            store.state.manageProfileCombineState!.residencyState!
                .residencyGetResponse!.data!.recidencyCountry) {
          residency_country_value = element.name;
          residency_country_id = element.id;
        }
        if (element.name ==
            store.state.manageProfileCombineState!.residencyState!
                .residencyGetResponse!.data!.growupCountry) {
          grow_up_country_value = element.name;
          grow_up_country_id = element.id;
        }
      });
    } else {
      country_value = null;
      residency_country_value = null;
      grow_up_country_value = null;
    }

    // print(country_value);
    // print(residency_country_value);
    // print(grow_up_country_value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) =>
          state.manageProfileCombineState!.residencyState!.isloading == false
              ? Scaffold(
                  appBar: CommonAppBarManageProfile(
                    text: AppLocalizations.of(context)!
                        .public_profile_residency_info,
                  ).build(context),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Const.kPaddingHorizontal,
                            vertical: Const.kPaddingVertical),
                        child: Form(
                            key: _formKey, child: build_body(context, state)),
                      ),
                    ),
                  ),
                )
              : CommonWidget.circularIndicator,
    );
  }

  build_birth_country(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_birth_country,
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
              value: country_value,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.countryList!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e.name,
                  child: Text(
                    e.name!,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                country_id = store.state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.countryList!
                    .where((item) => item.name!.contains(newValue))
                    .first
                    .id;
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_residency_country(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_residency_country,
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
            child:
                // CommonWidget().buildDropdownButtonFormField(
                //     state.manageProfileCombineState.presentAddressState
                //         .profile_dropdownResponse.data.countryList, (value) {
                //   residency_country_value = value.id;
                // }),
                DropdownButtonFormField<dynamic>(
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
              value: residency_country_value,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.countryList!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e.name,
                  child: Text(
                    e.name!,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                residency_country_id = store.state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.countryList!
                    .where((item) => item.name!.contains(newValue))
                    .first
                    .id;
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_immigration_status(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_immigration_status,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _immigration_status,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Immigration Status"),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  build_growup_country(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_growup_country,
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
              value: grow_up_country_value,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.countryList!
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e.name,
                  child: Text(
                    e.name!,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                grow_up_country_id = store.state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.countryList!
                    .where((item) => item.name!.contains(newValue))
                    .first
                    .id;
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_birth_country(context, state),
        build_residency_country(context, state),
        build_growup_country(context, state),
        build_immigration_status(context, state),
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (!_formKey.currentState!.validate()) {
              // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
            } else {
              store.dispatch(residencyUpdateMiddleware(
                      birth_country: country_id,
                      residency_country: residency_country_id,
                      growup_country: grow_up_country_id,
                      immigration_status: _immigration_status.text)
                  //
                  );
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
              child:
                  state.manageProfileCombineState!.residencyState!.pageloader ==
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
    );
  }
}

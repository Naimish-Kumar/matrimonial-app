import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../redux/libs/manage_profile/manage_profile_reducer/basic_info_reducer.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({Key? key}) : super(key: key);

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_basic_info,
        ).build(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: state.manageProfileCombineState!.basicInfoState!.formKey,
              child: build_body(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Const.kPaddingVertical,
          horizontal: Const.kPaddingHorizontal),
      color: Colors.white,
      width: DeviceInfo(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.introduction,
            style: Styles.bold_app_accent_14,
          ),
          Const.height25,
          //##############################first name######################################

          BasicFormWidget(
            text: AppLocalizations.of(context)!.manage_profile_f_name,
            style: Styles.bold_arsenic_12,
            controller: state
                .manageProfileCombineState!.basicInfoState!.f_nameController,
            hint: "Sara B.",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required field";
              }
              return null;
            },
          ),
          Const.height20,
          //##############################last name######################################

          BasicFormWidget(
            text: AppLocalizations.of(context)!.manage_profile_l_name,
            style: Styles.bold_arsenic_12,
            controller: state
                .manageProfileCombineState!.basicInfoState!.l_nameController,
            hint: "Dron",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required field";
              }
              return null;
            },
          ),
          Const.height20,
          //###############################gender#####################################

          GroupItemWithChild(
            title: AppLocalizations.of(context)!.manage_profile_gender,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    hintStyle: Styles.regular_arsenic_12,
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
                      .manageProfileCombineState!.basicInfoState!.gendervalue,
                  items: state
                      .manageProfileCombineState!.basicInfoState!.gender_items
                      .map<DropdownMenuItem<dynamic>>((e) {
                    return DropdownMenuItem<dynamic>(
                      value: e,
                      child: Text(
                        e,
                        style: Styles.regular_arsenic_14,
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      state.manageProfileCombineState!.basicInfoState!
                          .gendervalue = newValue;
                    });
                  }),
            ),
          ),
          Const.height20,
          //###############################date of birth#####################################

          GroupItemWithChild(
            title: AppLocalizations.of(context)!.manage_profile_dob,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyTheme.solitude,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate:
                      state.manageProfileCombineState!.basicInfoState!.date,
                  firstDate: DateTime(1923),
                  lastDate: DateTime.now(),
                );

                if (newDate == null) return;
                // setState(() => date = newDate.toString());
                store.dispatch(SetBasicDate(payload: newDate));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        DateFormat('y-MM-dd').format(DateTime.parse(state
                            .manageProfileCombineState!.basicInfoState!.date
                            .toString())),
                        style: Styles.regular_arsenic_14,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: MyTheme.gull_grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          Const.height20,
          //##############################phone number######################################

          BasicFormWidget(
            text: AppLocalizations.of(context)!.manage_profile_phone_num,
            style: Styles.bold_arsenic_12,
            controller: state
                .manageProfileCombineState!.basicInfoState!.phoneController,
            hint: "320-243-2537",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required field";
              }
              return null;
            },
          ),
          Const.height20,
          //################################on be half####################################

          GroupItemWithChild(
            title: AppLocalizations.of(context)!.manage_profile_onbehalf,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
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
                value: state.manageProfileCombineState!.basicInfoState!
                    .on_behalves_value,
                items: state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.onbehalfList!
                    .map<DropdownMenuItem<DDown>>((e) {
                  return DropdownMenuItem<DDown>(
                    value: e,
                    child: Text(
                      e.name!,
                      style: Styles.regular_arsenic_14,
                    ),
                  );
                }).toList(),
                onChanged: (DDown? newValue) {
                  state.manageProfileCombineState!.basicInfoState!
                      .on_behalves_value = newValue;
                },
              ),
            ),
          ),
          Const.height20,
          //################################marital status####################################

          GroupItemWithChild(
            title: AppLocalizations.of(context)!
                .advanced_search_screen_marital_status,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                value: state.manageProfileCombineState!.basicInfoState!
                    .marital_status_value,
                items: state.manageProfileCombineState!
                    .profiledropdownResponseData!.data!.maritialStatus!
                    .map<DropdownMenuItem<DDown>>((e) {
                  return DropdownMenuItem<DDown>(
                    value: e,
                    child: Text(
                      e.name!,
                      style: Styles.regular_arsenic_14,
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  state.manageProfileCombineState!.basicInfoState!
                      .marital_status_value = newValue;
                },
              ),
            ),
          ),
          Const.height20,
          //#################################no of children###################################

          BasicFormWidget(
            text: AppLocalizations.of(context)!.manage_profile_number_of_child,
            style: Styles.bold_arsenic_12,
            controller: state
                .manageProfileCombineState!.basicInfoState!.no_childController,
            hint: "No of children",
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Required field";
              }
              if (!isNumber(val)) {
                return "Must be a number";
              }
              return null;
            },
          ),
          Const.height20,
          //################################photo####################################

          GroupItemWithChild(
            title: AppLocalizations.of(context)!.manage_profile_photo,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                TextFormField(
                  readOnly: true,
                  decoration: InputStyle.inputDecoration_text_field(
                    hint: state.manageProfileCombineState!.basicInfoState!
                            .imageName ??
                        "Choose file",
                  ),
                ),
                Positioned(
                  right: 5,
                  child: SizedBox(
                    width: 100,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(MyTheme.white),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            store.dispatch(getBasicGalleryImageAction()),
                        child: Text(
                          'Browse',
                          style: Styles.regular_storm_grey_12,
                        )),
                  ),
                )
              ],
            ),
          ),
          Const.height20,
          //###################################submit#################################

          InkWell(
            onTap: () => store.dispatch(UpdateInfo.basicInfo),
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
                child: state.manageProfileCombineState!.basicInfoState!
                            .isloading ==
                        false
                    ? Text(
                        AppLocalizations.of(context)!.save_change_btn_text,
                        style: Styles.bold_white_14,
                      )
                    : CommonWidget.circularIndicator,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

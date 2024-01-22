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

class AstronomicInformation extends StatefulWidget {
  const AstronomicInformation({Key? key}) : super(key: key);

  @override
  State<AstronomicInformation> createState() => _AstronomicInformationState();
}

class _AstronomicInformationState extends State<AstronomicInformation> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _sunController = TextEditingController(
      text: store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse!.result ==
              false
          ? ""
          : store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse?.data?.sunSign ??
              "");
  TextEditingController _moonController = TextEditingController(
      text: store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse!.result ==
              false
          ? ""
          : store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse?.data?.moonSign ??
              "");

  TextEditingController _timeController = TextEditingController(
      text: store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse!.result ==
              false
          ? ""
          : store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse?.data?.timeOfBirth ??
              "");

  TextEditingController _cityofBirthController = TextEditingController(
      text: store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse!.result ==
              false
          ? ""
          : store.state.manageProfileCombineState!.astronomicState!
                  .astronomicGetResponse?.data?.cityOfBirth ??
              "");

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_astronomic_info,
        ).build(context),
        body: SingleChildScrollView(
          child: state.manageProfileCombineState!.astronomicState!.isloading ==
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
                              buildAstronomicInformation(context, state),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : CommonWidget.circularIndicator,
        ),
      ),
    );
  }

  Widget buildAstronomicInformation(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildtitle(context, state),
          buildsun(context, state),
          buildmoon(context, state),
          buildtimeofbirth(context, state),
          build_city_birth(context, state),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(
                //   msg: "Form's not validated!",
                // ));
              } else {
                store.dispatch(astronomicUpdateMiddleware(
                    sunsign: _sunController.text,
                    moonsign: _moonController.text,
                    time: _timeController.text,
                    city: _cityofBirthController.text));
              }
            },
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
                child: state.manageProfileCombineState!.astronomicState!
                            .pageloader ==
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
      ),
    );
  }

  Widget buildtitle(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_astronomic_info,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget buildsun(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.manage_profile_sun_sign} *",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _sunController,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            if (val.length > 255) {
              return "Max 255 characters";
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(hint: "Sun Sign"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildmoon(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.manage_profile_moon_sign} *",
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _moonController,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            if (val.length > 255) {
              return "Max 255 characters";
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(hint: "Moon Sign"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildtimeofbirth(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.manage_profile_time_of_birth} *",
          style: Styles.bold_arsenic_12,
        ),
        Const.height5,
        TextFormField(
          controller: _timeController,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            if (val.length > 10) {
              return "Max10 characters";
            }
            return null;
          },
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Time Of Birth"),
        ),
        /*TextButton(
          style: TextButton.styleFrom(
            backgroundColor: MyTheme.solitude,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              lastDate: DateTime(2100),
            );

            if (newDate == null) return;
            setState(() => date = newDate);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    DateFormat('d MMMM yyyy')
                        .format(DateTime.parse(date.toString())),
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
        ),*/
        Const.height20,
      ],
    );
  }

  Widget build_city_birth(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.manage_profile_city_of_birth} *",
          style: Styles.bold_arsenic_12,
        ),
        Const.height5,
        TextFormField(
          controller: _cityofBirthController,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            if (val.length > 20) {
              return "Max 20 characters";
            }
            return null;
          },
          decoration:
              InputStyle.inputDecoration_text_field(hint: "City of Birth"),
        ),
      ],
    );
  }
}

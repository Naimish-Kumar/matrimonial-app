import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_create_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_delete_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_get_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class EducationInfo extends StatefulWidget {
  const EducationInfo({Key? key}) : super(key: key);

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  final _formKey = GlobalKey<FormState>();

  // var index;
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _institutionController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_Education_info,
        ).build(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Const.kPaddingHorizontal,
                  right: Const.kPaddingHorizontal,
                ),
                child: buildTitle(context, state),
              ),
              Form(key: _formKey, child: build_body(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => store.dispatch(educationGetMiddleware()),
        child: ListView.separated(
          padding: EdgeInsets.only(
              left: Const.kPaddingHorizontal,
              right: Const.kPaddingHorizontal,
              bottom: 10),
          shrinkWrap: true,
          itemCount:
              state.manageProfileCombineState!.educationState!.list.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  boxShadow: [CommonWidget.box_shadow()]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .manage_profile_degree,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .educationState!
                                            .list[index]
                                            .degree_hint),
                                controller: state
                                    .manageProfileCombineState!
                                    .educationState!
                                    .list[index]
                                    .degree_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .manage_profile_institution,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .educationState!
                                            .list[index]
                                            .institute_hint),
                                controller: state
                                    .manageProfileCombineState!
                                    .educationState!
                                    .list[index]
                                    .institute_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .manage_profile_start,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .educationState!
                                            .list[index]
                                            .start_hint),
                                controller: state
                                    .manageProfileCombineState!
                                    .educationState!
                                    .list[index]
                                    .start_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.manage_profile_end,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .educationState!
                                            .list[index]
                                            .end_hint),
                                controller: state.manageProfileCombineState!
                                    .educationState!.list[index].end_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Status',
                              style: Styles.bold_arsenic_12,
                            ),
                            Switch(
                              value: state.manageProfileCombineState!
                                  .educationState!.list[index].present,
                              onChanged: (value) {
                                store.dispatch(EducationStatusAction(
                                    status: value,
                                    id: state.manageProfileCombineState!
                                        .educationState!.list[index].id));
                              },
                              activeColor: Colors.green,
                              activeTrackColor: MyTheme.zircon,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: MyTheme.zircon,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            state.manageProfileCombineState!.educationState!
                                .delIndex = index;

                            store.dispatch(eudcationDeleteMiddleware(
                                id: state
                                    .manageProfileCombineState!
                                    .educationState!
                                    .educationGetResponse!
                                    .data![index]
                                    .id));
                          },
                          child: Container(
                            height: 45,
                            width: DeviceInfo(context).width,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: MyTheme.app_accent_color),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                            child: Center(
                              child: state.manageProfileCombineState!
                                          .educationState!.isDelete! &&
                                      state.manageProfileCombineState!
                                              .educationState!.delIndex ==
                                          index
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MyTheme.storm_grey,
                                      ),
                                    )
                                  : Text(
                                      "Delete",
                                      style: Styles.bold_arsenic_14,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            state.manageProfileCombineState!.educationState!
                                .index = index;
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (!_formKey.currentState!.validate()) {
                              // store.dispatch(ShowMessageAction(
                              //     msg: "Form's not validated!"));
                            } else {
                              store.dispatch(eudcationUpdateMiddleware(
                                  degree: state
                                      .manageProfileCombineState!
                                      .educationState!
                                      .list[index]
                                      .degree_controller
                                      .text,
                                  institution: state
                                      .manageProfileCombineState!
                                      .educationState!
                                      .list[index]
                                      .institute_controller
                                      .text,
                                  start: state
                                      .manageProfileCombineState!
                                      .educationState!
                                      .list[index]
                                      .start_controller
                                      .text,
                                  end: state
                                      .manageProfileCombineState!
                                      .educationState!
                                      .list[index]
                                      .end_controller
                                      .text,
                                  id: state
                                      .manageProfileCombineState!
                                      .educationState!
                                      .educationGetResponse!
                                      .data![index]
                                      .id));
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
                              child: state.manageProfileCombineState!
                                          .educationState!.update_changes! &&
                                      state.manageProfileCombineState!
                                              .educationState!.index ==
                                          index
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MyTheme.storm_grey,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .save_change_btn_text,
                                      style: Styles.bold_white_14,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildTitle(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.public_profile_Your_Education_info,
              style: Styles.bold_app_accent_14,
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  OneContext().showDialog<void>(
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add New Education Info",
                              style: Styles.bold_arsenic_14,
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                color: MyTheme.storm_grey,
                                thickness: 1,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_degree,
                                hint: "Bachelor of Arts",
                                controller: _degreeController,
                                style: Styles.bold_arsenic_12,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_institution,
                                hint: "Middlebury College",
                                controller: _institutionController,
                                style: Styles.bold_arsenic_12,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_start,
                                hint: "Start",
                                controller: _startController,
                                style: Styles.bold_arsenic_12,
                                keyboard_type: TextInputType.number,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_end,
                                hint: "End",
                                controller: _endController,
                                style: Styles.bold_arsenic_12,
                                keyboard_type: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 1),
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
                                child: store.state.manageProfileCombineState!
                                            .educationState!.saveChanges !=
                                        false
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: MyTheme.storm_grey,
                                        ),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!
                                            .save_change_btn_text,
                                        style: Styles.bold_white_14,
                                      ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!_formKey.currentState!.validate()) {
                                // store.dispatch(ShowMessageAction(
                                //     msg: "Form's not validated!"));
                              } else {
                                store.dispatch(
                                  education_create_middleware(
                                    degree: _degreeController.text,
                                    institution: _institutionController.text,
                                    start: _startController.text,
                                    end: _endController.text,
                                  ),
                                );
                                _degreeController.clear();
                                _institutionController.clear();
                                _startController.clear();
                                _endController.clear();
                              }
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

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

class PhysicalAtrributes extends StatefulWidget {
  const PhysicalAtrributes({Key? key}) : super(key: key);

  @override
  State<PhysicalAtrributes> createState() => _PhysicalAtrributesState();
}

class _PhysicalAtrributesState extends State<PhysicalAtrributes> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_physical_attri,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: state
                        .manageProfileCombineState!.physicalAttrState!.formKey,
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
          AppLocalizations.of(context)!.manage_profile_physical_attri,
          style: Styles.bold_app_accent_14,
        ),
        Const.height25,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_height,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.heightController,
          keyboard_type: TextInputType.number,
          hint: "5.3",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter height";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_weight,
          style: Styles.bold_arsenic_12,
          keyboard_type: TextInputType.number,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.weightController,
          hint: "112.6 pounds (51.2 kilograms",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter weight";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_eye_color,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.eyeColorController,
          hint: "Blue",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter eye color";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_hair_color,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.physicalAttrState!
              .hairColorController,
          hint: "Black",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter hair color";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_complexion,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.physicalAttrState!
              .complexionController,
          hint: "Olive skin",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter complexion";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_body_type,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.bodyTypeController,
          hint: "Medium",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body type";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_body_art,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.bodyArtController,
          hint: "Body piercing",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body art";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_disability,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.physicalAttrState!
              .disabilityController,
          hint: "No",
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_blood_group,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.bloodController,
          hint: "A+",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter blood group";
            }
            if (value.length > 3) {
              return "Max 3 characters";
            }
            return null;
          },
        ),
        Const.height40,
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.physicalAttr),
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
              child: state.manageProfileCombineState!.physicalAttrState!
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

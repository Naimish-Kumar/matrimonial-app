import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyInformation extends StatefulWidget {
  const FamilyInformation({Key? key}) : super(key: key);

  @override
  State<FamilyInformation> createState() => _FamilyInformationState();
}

class _FamilyInformationState extends State<FamilyInformation> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_family_info,
        ).build(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal,
                  vertical: Const.kPaddingVertical),
              child: Form(
                key: state.manageProfileCombineState!.familyState!.formKey,
                child: buildBody(context, state),
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
          AppLocalizations.of(context)!.manage_profile_your_family_info,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 15,
        ),
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_father,
          child: TextFormField(
            controller:
                state.manageProfileCombineState!.familyState!.fatherController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(hint: "Father"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_mother,
          child: TextFormField(
            controller:
                state.manageProfileCombineState!.familyState!.motherController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(hint: "Mother"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_sibling,
          child: TextFormField(
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            controller: state
                .manageProfileCombineState!.familyState!.siblingController!,
            decoration: InputStyle.inputDecoration_text_field(hint: "Siblings"),
          ),
        ),
        Const.height40,
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.family),
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
              child: state.manageProfileCombineState!.familyState!.pageloader ==
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

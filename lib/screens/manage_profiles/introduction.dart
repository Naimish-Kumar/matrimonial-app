import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/common_widget.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.introduction,
        ).build(context),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal,
              vertical: Const.kPaddingVertical),
          child: Form(
            key: state.manageProfileCombineState!.introductionState!.formKey,
            child: buildBody(context, state),
          ),
        )),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.public_profile_your_introduction,
          style: Styles.bold_app_accent_12,
        ),
        Const.height25,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: MyTheme.solitude),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minHeight: 150),
          child: TextFormField(
            controller: state
                .manageProfileCombineState!.introductionState!.textController,
            decoration: const InputDecoration.collapsed(hintText: "Text..."),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Introduction';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.intro),
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
            child:
                state.manageProfileCombineState!.introductionState!.isLoading ==
                        false
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.save_change_btn_text,
                          style: Styles.bold_white_14,
                        ),
                      )
                    : CommonWidget.circularIndicator,
          ),
        ),
      ],
    );
  }
}

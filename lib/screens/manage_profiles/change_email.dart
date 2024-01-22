import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/common_app_bar_manageprofile.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  final my_email_controller = TextEditingController();
  late String value;

  @override
  void dispose() {
    my_email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarManageProfile(
              text: AppLocalizations.of(context)!
                  .change_email_screen_appbar_title)
          .build(context),
      body: SafeArea(
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
                    buildContactDetailsContainer(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactDetailsContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (text) {
              value = text;
            },
            controller: my_email_controller,
            decoration:
                InputStyle.inputDecoration_text_field(hint: "john@gmail.com"),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              var validated = EmailValidator.validate(value);
              print(validated);
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
                child: Text(
                  AppLocalizations.of(context)!.save_change_btn_text,
                  style: Styles.bold_white_14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

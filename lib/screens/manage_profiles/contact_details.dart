import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final _formKey = GlobalKey<FormState>();

  static var email =
      store.state.manageProfileCombineState!.contactState!.contactData!.email;

  TextEditingController _emailController = TextEditingController(text: email);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_contact_details,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: Form(key: _formKey, child: build_body(context, state)),
          ),
        ),
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_contact_details,
          style: Styles.bold_app_accent_14,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  build_email(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_email_id,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required Field";
            }
            // using regular expression
            if (!RegExp(r'\S+@\S+\.com').hasMatch(val)) {
              return "Please enter a valid email address";
            }
            return null;
          },
          controller: _emailController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Email address"),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_email(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) {
                // store.dispatch(ShowMessageAction(msg: "Form's not validated!"));
              } else {
                store.dispatch(contactMiddleware(email: _emailController.text));
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
                child: state.manageProfileCombineState!.contactState!.cdsave ==
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
          ),
        ],
      ),
    );
  }
}

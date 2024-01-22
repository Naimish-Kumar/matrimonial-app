import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/auth/change_password_middleware.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangePasswordViewModel>(
      converter: (store) => ChangePasswordViewModel.fromStore(store),
      builder: (_, ChangePasswordViewModel vm) => Scaffold(
        appBar: buildAppBar(context) as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal,
                  vertical: Const.kPaddingVertical),
              child: buildBody(context, vm),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, ChangePasswordViewModel vm) {
    return SizedBox(
      height: DeviceInfo(context).height,
      width: DeviceInfo(context).width,
      child: Column(
        children: [
          buildForm(context, vm),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                // print(vm.oldPasswordController.text);
                // print(vm.newPasswordController.text);
                // print(vm.newPasswordController.text);

                // store.dispatch(
                //   changePasswordMiddlware(
                //     old: vm.oldPasswordController.text,
                //     new_: vm.newPasswordController.text,
                //     confirm: vm.newPasswordController.text,
                //   ),
                // );
                vm.changepasswordmiddleware!(
                  oldpassord: vm.oldPasswordController.text,
                  newpassword: vm.newPasswordController.text,
                  confirmpassowrd: vm.newPasswordController.text,
                );

                vm.oldPasswordController.clear();
                vm.newPasswordController.clear();
                vm.confirmPasswordController.clear();
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
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: vm.loader == false
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.save_change_btn_text,
                        style: Styles.bold_white_14,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context, ChangePasswordViewModel vm) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFields(
            obscure_toggler: vm.oldpassfnc,
            obscure_text: vm.oldpassvalue,
            controller: vm.oldPasswordController,
            text: "Old password",
            title:
                AppLocalizations.of(context)!.change_password_screen_old_pass,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Please enter correct password';
              }
              return null;
            },
          ),
          FormFields(
            obscure_toggler: vm.newpassfnc,
            obscure_text: vm.newpassvalue,
            controller: vm.newPasswordController,
            text: "New password",
            title:
                AppLocalizations.of(context)!.change_password_screen_new_pass,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please enter correct password";
              }
              return null;
            },
          ),
          FormFields(
            obscure_toggler: vm.confirmpassfnc,
            obscure_text: vm.confirmpassvalue,
            controller: vm.confirmPasswordController,
            text: "Confirm password",
            title: AppLocalizations.of(context)!
                .change_password_screen_confirm_pass,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Confirm Password';
              }
              if (vm.newPasswordController.text.toString() !=
                  vm.confirmPasswordController.text.toString()) {
                return "Password don't match";
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context)!.change_password,
        style: Styles.bold_arsenic_14,
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  var value;
  var controller;
  var text;
  var title;
  var validator;
  Function? obscure_toggler;
  var obscure_text;

  FormFields({
    Key? key,
    this.value,
    this.controller,
    this.text,
    this.title,
    this.validator,
    this.obscure_text,
    this.obscure_toggler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: obscure_text,
          validator: validator,
          controller: controller,
          decoration: InputStyle.inputDecoration_text_field(
            hint: text,
            suffixIcon: InkWell(
                onTap: () {
                  obscure_toggler!();
                },
                child: obscure_text
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility)),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class ChangePasswordViewModel {
  var oldPasswordController;
  var newPasswordController;
  var confirmPasswordController;
  var loader;

  // functions
  void Function()? oldpassfnc;
  void Function()? newpassfnc;
  void Function()? confirmpassfnc;
  void Function(
      {dynamic oldpassord,
      dynamic newpassword,
      dynamic confirmpassowrd})? changepasswordmiddleware;

  var oldpassvalue;
  var newpassvalue;
  var confirmpassvalue;

  ChangePasswordViewModel({
    this.oldPasswordController,
    this.newPasswordController,
    this.confirmPasswordController,
    this.loader,
    this.oldpassfnc,
    this.newpassfnc,
    this.confirmpassfnc,
    this.oldpassvalue,
    this.newpassvalue,
    this.confirmpassvalue,
    this.changepasswordmiddleware,
  });

  static fromStore(Store<AppState> store) {
    return ChangePasswordViewModel(
      oldPasswordController:
          store.state.changePasswordState!.oldPasswordController,
      newPasswordController:
          store.state.changePasswordState!.newPasswordController,
      confirmPasswordController:
          store.state.changePasswordState!.confirmPasswordController,
      loader: store.state.changePasswordState!.cp_loader,

      // value
      oldpassvalue: store.state.changePasswordState!.oldpass,
      newpassvalue: store.state.changePasswordState!.newpass,
      confirmpassvalue: store.state.changePasswordState!.confirmpass,

      // functions
      oldpassfnc: () => store.dispatch(obscure.oldpass),
      newpassfnc: () => store.dispatch(obscure.newpass),
      confirmpassfnc: () => store.dispatch(obscure.confirmpass),

      changepasswordmiddleware: (
              {dynamic oldpassord,
              dynamic newpassword,
              dynamic confirmpassowrd}) =>
          store.dispatch(
        changePasswordMiddlware(
          old: oldpassord,
          new_: newpassword,
          confirm: confirmpassowrd,
        ),
      ),
    );
  }
}

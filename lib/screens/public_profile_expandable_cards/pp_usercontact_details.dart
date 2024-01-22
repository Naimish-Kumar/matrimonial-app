import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/contact_view_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import '../../redux/libs/helpers/show_message_state.dart';

class PP_UserContactDetails extends StatelessWidget {
  int userid;

  PP_UserContactDetails({Key? key, required this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserContactViewModel>(
      converter: (store) => UserContactViewModel.fromStore(store),
      builder: (_, UserContactViewModel vm) => vm.contact != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .public_profile_contact_number,
                    data: "${vm.phone}"),
                const SizedBox(
                  height: 10,
                ),
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_email,
                    data: "${vm.email}"),

                const SizedBox(
                  height: 20,
                ),

                /// view contact info

                Visibility(
                  visible: !vm.isviewed,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8.0),
                      backgroundColor: MyTheme.app_accent_color,
                    ),
                    onPressed: () {
                      vm.remainingContact == 0 || vm.isPackageExpired
                          ? store.dispatch(ShowMessageAction(
                              msg: "Please update your package."))
                          : confirm_contact_view(vm: vm, id: userid);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: DeviceInfo(context).width,
                      child: Text(
                        "View Contact Info",
                        style: Styles.bold_white_12,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            ),
    );
  }

  Row buildRow(
      {BuildContext? context, required localization_text, required data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(localization_text, style: Styles.regular_gull_grey_12)),
        Expanded(
          child: Text(data),
        )
      ],
    );
  }

  /// show dialog
  Future<void> confirm_contact_view({UserContactViewModel? vm, id}) {
    return OneContext().showDialog<void>(
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm Contact View',
            style: Styles.bold_arsenic_14,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Remaining Contact View: ${vm!.remainingContact} times',
                style: Styles.bold_arsenic_12,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '**N.B. Viewing This Members Contact Information Will Cost 1 From Your Remaining \nContact View**',
                style: Styles.regular_app_accent_12,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyTheme.zircon,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(color: MyTheme.arsenic),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: Styles.buildLinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: MyTheme.white),
                  )),
              onPressed: () {
                vm.contactView!(id: userid);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class UserContactViewModel {
  var phone;
  var email;
  var contact;
  var isviewed;
  var remainingContact;
  var isPackageExpired;

  void Function({dynamic id})? contactView;

  UserContactViewModel(
      {this.phone,
      this.email,
      this.isPackageExpired,
      this.contact,
      this.isviewed,
      this.remainingContact,
      this.contactView});

  static fromStore(Store<AppState> store) {
    return UserContactViewModel(
      contact: store.state.publicProfileState!.contact,
      isviewed: store.state.publicProfileState!.viewContactCheck,
      phone: store.state.publicProfileState!.viewContactCheck
          ? store.state.publicProfileState!.contact.phone
          : '+xx xxx xxx xxx',
      email: store.state.publicProfileState!.viewContactCheck
          ? store.state.publicProfileState!.contact.email
          : 'xxxxx@xxx.xx',
      remainingContact:
          store.state.accountState!.profileData!.remainingContactView,
      isPackageExpired: store.state.accountState!.profileData!
                  .currentPackageInfo!.packageExpiry ==
              'Expired'
          ? true
          : false,
      // contactView: () => store.dispatch(ContactViewAction()),
      // contactView: ({dynamic id}) => store.dispatch(publicProfileMiddleware(userId: id)),
      contactView: ({dynamic id}) => store.dispatch(postContactView(id: id)),
    );
  }
}

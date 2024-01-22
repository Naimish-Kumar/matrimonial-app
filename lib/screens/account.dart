import 'package:active_matrimonial_flutter_app/components/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/my_text_button.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/grid_items.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/deactivate_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/change_password.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/manage_profile.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_gallery.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_details.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:active_matrimonial_flutter_app/screens/verify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/common_privacy_and_terms_page.dart';
import '../components/matched_profile_widget.dart';
import '../components/remaining_box.dart';
import '../redux/libs/auth/acccount_delete_middleware.dart';
import '../redux/libs/staticPage/static_page.dart';
import '../redux/libs/verify/verify_action.dart';
import 'contact_us.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool? isSupport = store.state.addonState?.data?.supportTickets ?? false;
  bool? isReferral = store.state.addonState?.data?.referralSystem ?? false;
  bool isSmallScreen = false;
  var _menuList;

  void fnc_deactivate(deactivate, items) {
    if (deactivate) {
      if (items.length == 5) {
        items.removeLast();
      }
      items.add("Reactivate Account");
    } else {
      if (items.length == 5) {
        items.removeLast();
      }
      items.add("Deactivate account");
    }
  }

  List<String> items = [
    'FAQ',
    'Contact Us',
    'Logout',
    'Change Password',
    'Delete account'
  ];

  fetchMenu() {
    var obj = GridItems();
    obj.addMenu();
    _menuList = obj.gridMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    if (prefs.getBool(Const.deactivate) != true) {
      prefs.setBool(Const.deactivate, false);
    }
    var deactivate = prefs.getBool(Const.deactivate)!;
    fnc_deactivate(deactivate, items);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        fetchMenu(),
        store.dispatch(getUserIsApproveAction()),
        store.dispatch(happyStoryCheckMiddleware()),
        store.dispatch(fetchStaticPageAction()),
        store.dispatch(matchedProfileFetchAction()),
      ],
      builder: (_, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              store.dispatch(getUserIsApproveAction());
              store.dispatch(authMiddleware());
              store.dispatch(accountMiddleware());
              store.dispatch(featureCheckMiddleware());
              store.dispatch(matchedProfileFetchAction());

              return Future.delayed(const Duration(seconds: 2));
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // bottom page of the stack
                  buildGradientBoxContainer(context, state, items),
                  buildGridContainer(context, state),

                  /// this section represents only about packages
                  /// upgrade the package go to packages that are available

                  Padding(
                    padding: EdgeInsets.only(
                        left: Const.kPaddingHorizontal,
                        right: Const.kPaddingHorizontal,
                        bottom: 20),
                    child: buildPackageDetails(context, state),
                  ),
                  if (!state.userVerifyState!.isApprove!)
                    Padding(
                      padding: EdgeInsets.only(
                          left: Const.kPaddingHorizontal,
                          right: Const.kPaddingHorizontal,
                          bottom: 20),
                      child: buildVerify(context, state),
                    ),

                  /// match profile box
                  MatchedProfileWidget(
                      matched_profile_controller:
                          state.accountState!.matched_profile_controller,
                      state: state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGradientBoxContainer(mainContext, AppState state, items) {
    return Container(
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
          child: Column(
            children: [
              /// image name email and other more vertz field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: MyImages.normalImage(
                              state.accountState?.profileData?.memberPhoto!),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.state.authState?.userData?.name ?? "",
                            style: Styles.bold_white_14,
                          ),
                          Text(
                            store.state.authState?.userData?.email ?? "",
                            style: Styles.regular_white_12,
                          )
                        ],
                      )
                    ],
                  ),
                  buildHomePopupMenuButton(mainContext, items, state),
                ],
              ),

              /// common white back widgets
              Const.height15,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                /// public profile
                /// this will go to mypublic profile
                /// which is myPublicProfie

                MyTextButton(
                  text: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_public_profile,
                      style: Styles.regularWhite(context, 3),
                      // style: Styles.regular_white_12
                    ),
                  ),
                  onPressed: () => NavigatorPush.push(
                      context,
                      UserPublicProfile(
                        userId: store.state.authState!.userData!.id!,
                      )),
                ),

                /// manage profile
                /// this will go to my profile
                /// which is my profile

                MyTextButton(
                  onPressed: () => NavigatorPush.push(context, MyProfile()),
                  text: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_manage_profile,
                      style: Styles.regularWhite(context, 3),
                      // style: Styles.regular_white_12
                    ),
                  ),
                ),

                /// gallery
                /// this will go to my gallery
                /// which is mygallery

                MyTextButton(
                  onPressed: () {
                    NavigatorPush.push(context, MyGallery());
                  },
                  text: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.profile_screen_gallery,
                      style: Styles.regularWhite(context, 3),
                      // style: Styles.regular_white_12
                    ),
                  ),
                ),
              ]),
              Const.height15,

              /// horzontal line
              Const.whiteDivider,
              Const.height15,

              /// remaining boxes in are below
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RemainingBox(
                          context: context,
                          localization_text: AppLocalizations.of(context)!
                              .profile_screen_r_interest,
                          value: state
                              .accountState!.profileData?.remainingInterest),
                      RemainingBox(
                          context: context,
                          localization_text: AppLocalizations.of(context)!
                              .profile_screen_r_contact_view,
                          value: state
                              .accountState!.profileData?.remainingContactView),
                      RemainingBox(
                          context: context,
                          localization_text: AppLocalizations.of(context)!
                              .profile_screen_r_gallery_image_upload,
                          value: state.accountState!.profileData
                              ?.remainingPhotoGallery),
                    ],
                  ),
                  Const.height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      state.accountState!.profileData
                                  ?.remainingProfileImageView !=
                              ""
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .profile_screen_r_profile_image_view,
                                    style: Styles.regular_white_12,
                                    textAlign: TextAlign.center,
                                  ),
                                  Const.height5,
                                  Text(
                                    state.accountState?.profileData
                                            ?.remainingProfileImageView
                                            .toString() ??
                                        "",
                                    style: Styles.medium_white_22,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Const.height5,
                      state.accountState!.profileData
                                  ?.remainingGalleryImageView !=
                              ""
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .profile_screen_r_gallery_image_view,
                                    style: Styles.regular_white_12,
                                    textAlign: TextAlign.center,
                                  ),
                                  Const.height5,
                                  Text(
                                    state.accountState?.profileData
                                            ?.remainingGalleryImageView
                                            .toString() ??
                                        "",
                                    style: Styles.medium_white_22,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridContainer(BuildContext context, AppState state) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _menuList.length,
        controller: state.accountState!.gridScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            childAspectRatio: 1),
        padding: const EdgeInsets.only(left: 24.0, top: 20, right: 24),
        itemBuilder: (context, index) {
          return _menuList[index];
        });
  }

  Widget buildVerify(BuildContext context, AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.app_accent_color),
        color: MyTheme.app_accent_color.withOpacity(.09),
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      // height: 111,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 15.0, right: 8.0, bottom: 15.0),
        child: Column(
          children: [
            /// package and upgrade package
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/verify.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('Not Verified')
                      ],
                    )
                  ],
                ),
                // package list
                MyTextButton(
                  onPressed: () {
                    NavigatorPush.push(context, VerifyPage());
                  },
                  text: Text(
                    "Verify Now",
                    style: Styles.bold_white_10,
                  ),
                  color: MyTheme.app_accent_color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageDetails(BuildContext context, AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.app_accent_color),
        color: MyTheme.solitude,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      // height: 111,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 15.0, right: 8.0, bottom: 15.0),
        child: Column(
          children: [
            /// package and upgrade package
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.profile_screen_package,
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState!.profileData?.currentPackageInfo
                                  ?.packageName ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .profile_screen_expire_on,
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState!.profileData?.currentPackageInfo
                                  ?.packageExpiry ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                  ],
                ),
                // package list
                MyTextButton(
                  onPressed: () {
                    NavigatorPush.push(context, PremiumPlans());
                  },
                  text: Text(
                    AppLocalizations.of(context)!.profile_screen_upgrade,
                    style: Styles.bold_white_10,
                  ),
                  color: MyTheme.app_accent_color,
                ),
              ],
            ),
            Const.height5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // package details button
                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_package_details,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    context,
                    PackageDetails(
                        packageId: state.accountState!.profileData!
                            .currentPackageInfo!.packageId),
                  ),
                ),
                // package history button

                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_package_history,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    context,
                    PackageHistory(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// pop up menu details page

  Widget buildHomePopupMenuButton(mainContext, List items, AppState state) {
    return Container(
      width: 15,
      child: PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 20,
        ),
        onSelected: (dynamic value) {
          switch (value.toString().toLowerCase()) {
            case 'contact us':
              NavigatorPush.push(context, ContactUs());
              break;

            case 'faq':
              NavigatorPush.push(
                  context,
                  CommonPrivacyAndTerms(
                    title: "Frequently Asked Questions (FAQ)",
                    content: state.staticPageState!.faq,
                  ));
              break;

            case 'change password':
              NavigatorPush.push(context, ChangePassword());
              break;

            case 'deactivate account':
              _dialogBuilder(mainContext, state);
              break;

            case 'reactivate account':
              store.dispatch(deactivateMiddleware(deactivate_status: 0));
              prefs.remove(Const.deactivate);
              prefs.setBool(Const.deactivate, false);

              break;

            case 'delete account':
              accountDeletion(state);
              break;

            case 'logout':
              store.dispatch(signOutMiddleware(context));
              break;
          }
        },
        itemBuilder: (context) {
          return items
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
              .toList();
        },
      ),
    );
  }

  accountDeletion(AppState state) {
    return OneContext().showDialog(builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Do You Really Want To Delete Your Account',
          style: Styles.bold_arsenic_14,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(255, 221, 218, 1),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: MyTheme.arsenic),
              ),
            ),
            onPressed: () {
              OneContext().popDialog();
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
                color: const Color.fromRGBO(201, 227, 202, 1),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(color: MyTheme.arsenic),
              ),
            ),
            onPressed: () {
              store.dispatch(accountDeletionMiddleware());
              OneContext().popDialog();
            },
          ),
        ],
      );
    });
  }

  _dialogBuilder(mainContext, AppState state) {
    return showDialog<void>(
      context: mainContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(AppLocalizations.of(context)!.deactivate,
                    textAlign: TextAlign.center,
                    style: Styles.bold_app_accent_20),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: Styles.buildLinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: TextButton(
                        onPressed: () {
                          store.dispatch(
                            deactivateMiddleware(deactivate_status: 1),
                          );
                          prefs.remove(Const.deactivate);
                          prefs.setBool(Const.deactivate, true);

                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(90.0, 45.0)),
                          overlayColor: MaterialStateProperty.all(
                              MyTheme.app_accent_color),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                                side: BorderSide(
                                    color: MyTheme.app_accent_color)),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          style: Styles.bold_arsenic_16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(90.0, 45.0)),
                        overlayColor:
                            MaterialStateProperty.all(MyTheme.app_accent_color),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                              side:
                                  BorderSide(color: MyTheme.app_accent_color)),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.no,
                        style: Styles.bold_arsenic_16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

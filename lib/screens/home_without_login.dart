import 'dart:io';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/container_with_icon.dart';
import 'package:active_matrimonial_flutter_app/components/custom_popup.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

class HomeWithoutLogin extends StatefulWidget {
  const HomeWithoutLogin({Key? key}) : super(key: key);

  @override
  State<HomeWithoutLogin> createState() => _HomeWithoutLoginState();
}

class _HomeWithoutLoginState extends State<HomeWithoutLogin> {
  // page view controller
  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 1);

  // page view page number
  int current_page = 0;

  goNextPage() {
    controller.animateToPage(
      current_page + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  goPrevPage() {
    controller.animateToPage(
      current_page - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //
  // bool isLogin = prefs.getBool("isLogin") ?? false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(fetchPremiumMembersAction()),
      ],
      builder: (_, state) => WillPopScope(
        onWillPop: () async {
          final shouldPop = (await OneContext().showDialog<bool>(
            builder: (BuildContext context) {
              return exit_dialog(context);
            },
          ))!;
          return shouldPop;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(context) as PreferredSizeWidget?,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Const.kPaddingHorizontal,
                  right: Const.kPaddingHorizontal,
                  bottom: Const.kPaddingVertical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: state.exploreState!.isFetchingPremiumMembers!
                        ? CommonWidget.circularIndicator
                        : state.exploreState!.premiumMemberList!.isNotEmpty
                            ? PageView.builder(
                                controller: controller,
                                itemCount: state
                                    .exploreState!.premiumMemberList!.length,
                                itemBuilder: (listViewContext, index) {
                                  var members =
                                      state.exploreState!.premiumMemberList!;

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4.0),
                                    child: Stack(
                                      children: [
                                        // image container
                                        image_container(members, index),
                                        // transparent and black shade over image
                                        transparent_black_shade_over(),
                                        // here is the user info box
                                        // also there is five box with onPressed function
                                        // two of them are for go to previous page and next page
                                        // others three are for
                                        // ignore
                                        // love

                                        // shortlist
                                        user_info_box_with(
                                            context, members, index, state)
                                      ],
                                    ),
                                  );
                                },
                                onPageChanged: (index) {
                                  setState(() {
                                    current_page = index;
                                  });
                                  prefs.setBool(Const.showDialog, false);
                                },
                              )
                            : CommonWidget.noData,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget user_info_box_with(
      BuildContext context, var members, int index, AppState state) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 150,
          width: DeviceInfo(context).width,
          child: Column(
            children: [
              // named row
              name_icon_row(members, index),
              //member id row
              member_id_row(context, members, index),
              // age, height, location and full profile row
              btn_and_age_country_row(members, index, context),
              const SizedBox(
                height: 12,
              ),
              // page navigator with subscribe, love and follow button
              buildPageNavigatorWithSubscribeLoveFollow(
                  context, members[index], state),
            ],
          ),
        ),
      ),
    );
  }

  Widget exit_dialog(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.exit,
          style: Styles.bold_arsenic_14),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () {
            // Navigator.pop(context, true);
            Platform.isAndroid ? SystemNavigator.pop() : exit(0);
          },
          child: Text('Yes', style: Styles.regular_arsenic_14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('No', style: Styles.regular_arsenic_14),
        ),
      ],
    );
  }

  Widget btn_and_age_country_row(var members, int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ImageIcon(
                  AssetImage('assets/icon/icon_person.png'),
                  size: 12,
                  color: MyTheme.white,
                ),
                const SizedBox(
                  width: 5,
                ),

                // age and height row
                Text(
                  // TODO INch WILL BE HERE
                  '${members[index].age} yrs, ${members[index].height} ft',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                const ImageIcon(
                  AssetImage('assets/icon/icon_location.png'),
                  size: 12,
                  color: MyTheme.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  members[index].country,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),

        /// full profile button
        TextButton(
          onPressed: () {
            CustomPopUp(context).loginDialog(context);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(BorderSide(color: Colors.white)),
          ),
          child: Text(
            AppLocalizations.of(context)!.home_screen_full_profile,
            style: const TextStyle(color: MyTheme.white),
          ),
        ),
      ],
    );
  }

  Widget member_id_row(BuildContext context, var members, int index) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.common_screen_member_id,
          style: const TextStyle(color: MyTheme.white),
        ),
        Text(
          members[index].code,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget name_icon_row(var members, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            members[index].name == ''
                ? const Text('')
                : Text(
                    members[index].name,
                    style: Styles.bold_white_16,
                  ),
            const SizedBox(
              width: 7,
            ),
            members[index].membership == 2
                ? ImageIcon(
                    const AssetImage('assets/icon/icon_premium.png'),
                    size: 18,
                    color: MyTheme.icon_premium_color,
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  Widget image_container(var members, int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            isAntiAlias: true,
            image: (members[index].photo == null
                ? AssetImage('assets/images/220x320.png')
                : NetworkImage(members[index].photo)) as ImageProvider<Object>,
            fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget transparent_black_shade_over() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.4,
              1,
            ],
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppbarRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/logo/appbar_logo.png',
                fit: BoxFit.contain,
                height: 36,
                width: 46,
              ),
              const SizedBox(
                width: 8.3,
              ),
              Text(
                AppConfig.app_name,
                style: Styles.bold_app_accent_16,
              ),
            ],
          ),
          Row(
            children: [
              CommonWidget.social_button(
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                icon: "icon_bell.png",
                onpressed: () {
                  CustomPopUp(context).loginDialog(context);
                },
              ),
              const SizedBox(
                width: 8.0,
              ),
              CommonWidget.social_button(
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                  icon: "icon_search.png",
                  onpressed: () {
                    CustomPopUp(context).loginDialog(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: buildAppbarRow(context),
    );
  }

  Widget buildPageNavigatorWithSubscribeLoveFollow(
      BuildContext context, dynamic user, AppState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// go to left
        ContainerWithIcon(
          onpressed: () {
            goPrevPage();
          },
          icon: 'icon_left.png',
          width: 42,
          height: 42,
          radius: 20,
          opacity: 0.1,
          color: Colors.white,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// add to ignore
            ContainerWithIcon(
                onpressed: () {
                  CustomPopUp(context).loginDialog(context);
                },
                icon: 'icon_ignore.png',
                width: 42,
                height: 42,
                radius: 20,
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
            SizedBox(
              width: DeviceInfo(context).width! * 0.05,
            ),

            /// add to interest
            ContainerWithIcon(
                onpressed: () {
                  CustomPopUp(context).loginDialog(context);
                },
                icon: 'icon_love.png',
                width: 42,
                height: 42,
                radius: 20,
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
            SizedBox(
              width: DeviceInfo(context).width! * 0.05,
            ),

            /// add to shortlist
            ContainerWithIcon(
                onpressed: () {
                  CustomPopUp(context).loginDialog(context);
                },
                icon: 'icon_subscribe.png',
                width: 42,
                height: 42,
                radius: 20,
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ],
        ),
        ContainerWithIcon(
          onpressed: () {
            goNextPage();
          },
          icon: 'icon_right.png',
          width: 42,
          height: 42,
          radius: 20,
          opacity: 0.1,
          color: Colors.white,
        ),
      ],
    );
  }
}

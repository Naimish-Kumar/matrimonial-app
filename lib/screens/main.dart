import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/connectivity_helper.dart';
import 'package:active_matrimonial_flutter_app/helpers/get_context.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/common/common_states_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_list.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/explore.dart';
import 'package:active_matrimonial_flutter_app/screens/home.dart';
import 'package:active_matrimonial_flutter_app/screens/home_without_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/push_notification_service.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemHelper.context = context;

    //Check network connection
    ConnectivityHelper().abortIfNotConnected(context, onPop);

    //Check the common dropdown value is null
    !(store.state.manageProfileCombineState?.profiledropdownResponseData
                ?.result ??
            false)
        ? store.dispatch(profiledropdownMiddleware())
        : null;
    //Check the common dropdown value is null
    (store.state.commonState?.countries?.isEmpty ?? true)
        ? store.dispatch(commonStateCountryMiddleware())
        : null;

    Future.delayed(const Duration(milliseconds: 1), () async {
      await PushNotificationService().initNotifications();
    });
  }

  onPop(value) {
    ConnectivityHelper().abortIfNotConnected(context, onPop);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {}
        return true;
      },
      child: Scaffold(
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) => body(context, state)),
        bottomNavigationBar: buildBottomNavigationContainer(context),
      ),
    );
  }

  Widget body(BuildContext context, AppState state) {
    // var isLogin = store.state.authState?.userData !=null ;
    // print("is Login $isLogedin");

    if (_currentIndex == 0) {
      if (isLogedin) {
        return Home();
      } else {
        return HomeWithoutLogin();
      }
    } else if (_currentIndex == 1)
      return Explore();
    else if (_currentIndex == 2) {
      if (isLogedin) {
        return ChatList(
          backButtonAppearance: false,
        );
      } else {
        return Login();
      }
    } else if (_currentIndex == 3) {
      if (isLogedin) {
        return Account();
      } else {
        return Login();
      }
    }
    return SizedBox.shrink();
  }

  Widget buildBottomNavigationContainer(BuildContext context) {
    return SizedBox(
      height: 75,
      child: BottomAppBar(
        color: MyTheme.zircon,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: MyTheme.zircon,
          selectedItemColor: MyTheme.app_accent_color,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: MyTheme.storm_grey,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_members.png',
              size: 18.0,
              label: AppLocalizations.of(context)!.common_active_members,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_explore.png',
              size: 18.0,
              label: AppLocalizations.of(context)!.common_active_explore,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_chat.png',
              size: 18.0,
              label: AppLocalizations.of(context)!.common_active_chat,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_account.png',
              size: 18.0,
              label: AppLocalizations.of(context)!.common_active_account,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(BuildContext context,
      {required String icon, double? size, dynamic label, dynamic page}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageIcon(
          AssetImage(icon),
          size: size,
        ),
      ),
      label: label,
    );
  }
}

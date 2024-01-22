import 'package:active_matrimonial_flutter_app/components/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/get_context.dart';
import 'package:active_matrimonial_flutter_app/helpers/localization.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_middleware.dart';
import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  void initState() {
    SystemHelper.isBlockScreenShown = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        body: Container(
          width: DeviceInfo(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.not_interested,
                size: 40,
                color: MyTheme.light_grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your account has been banned.",
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.app_accent_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonPaddingZero(
                background: MyTheme.app_accent_color,
                onPressed: () {
                  store.dispatch(signOutMiddleware(context));
                },
                text: Text(
                  LangText(context: SystemHelper.context).getLocal()!.logout,
                  style: TextStyle(
                      fontSize: 16,
                      color: MyTheme.white,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../redux/libs/app_info/app_info_action.dart';

class OnBoardingPages extends StatefulWidget {
  const OnBoardingPages({Key? key}) : super(key: key);

  @override
  State<OnBoardingPages> createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: DeviceInfo(context).height,
              decoration: BoxDecoration(
                gradient: Styles.buildLinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.8, 1),
                ),
              ),
              child: SafeArea(
                child: state.appInfoState!.isFetching!
                    ? CommonWidget.circularIndicator
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: DeviceInfo(context).height! * .5,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: state.appInfoState!.list!.length,
                              onPageChanged: (index) {
                                store.dispatch(
                                    ShowGetStartedAction(payload: index));
                              },
                              itemBuilder: (context, index) {
                                return AppInfoCard(
                                  itemIndex: index,
                                  itemLength: state.appInfoState!.list!.length,
                                  icon: state.appInfoState!.list![index].icon,
                                  steps: state.appInfoState!.list![index].steps,
                                  hwt_title: state
                                      .appInfoState!.list![index].hwt_title,
                                  hwt_subtitle: state
                                      .appInfoState!.list![index].hwt_subtitle,
                                );
                              },
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: state.appInfoState!.list!.length,
                            effect: ExpandingDotsEffect(
                                dotColor: Colors.white.withOpacity(0.8),
                                activeDotColor: Colors.white,
                                dotHeight: 8,
                                dotWidth: 8),
                          ),
                        ],
                      ),
              ),
            ),
            if (store.state.appInfoState!.showGetStarted!)
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  alignment: const Alignment(0, 0.50),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          prefs.setBool(Const.isView, true);
                          NavigatorPush.push(context, const Main());
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size(144.0, 52.0)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                side: BorderSide(color: MyTheme.white)),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.common_get_started,
                          style: Styles.bold_white_14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class AppInfoCard extends StatelessWidget {
  int? itemLength;
  int? itemIndex;
  String? icon;
  int? steps;
  String? hwt_title;
  String? hwt_subtitle;

  AppInfoCard({
    Key? key,
    this.itemLength,
    this.itemIndex,
    this.icon,
    this.steps,
    this.hwt_title,
    this.hwt_subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon how it works in the position
          SizedBox(
            child: icon != null
                ? Image.network(
                    icon!,
                    height: 72,
                    width: 85,
                  )
                : const Icon(Icons.error),
          ),
          Const.height15,
          //  number position in the how it works screen
          Text(
            "$steps",
            style: Styles.bold_white_36,
          ),
          Const.height15,
          Text(
            hwt_title!,
            style: Styles.bold_white_22,
          ),
          Const.height15,
          SizedBox(
            width: 200,
            child: Text(
              hwt_subtitle!,
              style: Styles.regular_white_14,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

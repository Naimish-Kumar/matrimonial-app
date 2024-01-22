import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/my_text_button.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/lading_page/landing.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/on_boarding_pages.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(fetchLandingSliderAction()),
      ],
      builder: (_, state) => Scaffold(
        body: SizedBox(
          height: DeviceInfo(context).height,
          child: Stack(
            children: [
              SizedBox(
                height: DeviceInfo(context).height! * .70,
                child: state.landingState!.isFetchingSlider!
                    ? CommonWidget.circularIndicator
                    : CarouselSlider.builder(
                        carouselController:
                            state.landingState!.carouselController,
                        itemCount: state.landingState!.sliderImageList!.length,
                        itemBuilder: (context, index, realIndex) {
                          return state.landingState!.sliderImageList!.isNotEmpty
                              ? MyImages.normalImage(state.landingState!
                                      .sliderImageList![index].image ??
                                  '')
                              : CommonWidget.noData;
                        },
                        options: CarouselOptions(
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            store
                                .dispatch(SetCarouselIndexAction(index: index));
                          },
                          // enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      ),
              ),
              // upper most container
              Positioned(
                bottom: 0,
                child: Container(
                  width: DeviceInfo(context).width,
                  decoration: BoxDecoration(
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSmoothIndicator(
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.white.withOpacity(0.8),
                                activeDotColor: Colors.white,
                                dotHeight: 8,
                                dotWidth: 8,
                              ),
                              activeIndex: state.landingState!.carouselIndex!,
                              count:
                                  state.landingState!.sliderImageList!.length ??
                                      0,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          AppLocalizations.of(context)!.landing_page_title,
                          // style: Styles.bold_white_30,
                          style: Styles.regularWhiteBold(context, 10),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.landing_page_sub_title,
                          style: Styles.regular_white_14,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextButton(
                              horizontal: 18.0,
                              vertical: 10.0,
                              color: Colors.black.withOpacity(0.1),
                              onPressed: () {
                                prefs.setBool(Const.isView, true);
                                NavigatorPush.push(
                                  context,
                                  const Main(),
                                );
                              },
                              text: Text(
                                AppLocalizations.of(context)!
                                    .common_get_started,
                                style: Styles.bold_white_14,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavigatorPush.push(
                                    context,
                                    const OnBoardingPages(),
                                  );
                                },
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .landing_page_how_it_works,
                                    style: Styles.italic_white_14))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

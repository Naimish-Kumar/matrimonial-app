import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../helpers/device_info.dart';
import '../redux/libs/explore/explore_action.dart';
import '../screens/core.dart';
import 'common_widget.dart';
import 'my_animated_smooth_indicator.dart';

class BannerWidget extends StatelessWidget {
  final bool? isSlider;
  final isFetching;
  final bannerList;
  final carouselIndex;
  final controller;

  BannerWidget({
    this.isSlider,
    this.isFetching,
    this.bannerList,
    this.carouselIndex,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          width: DeviceInfo(context).width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: isFetching
              ? CommonWidget.circularIndicator
              : bannerList.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: bannerList.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: bannerList[index].image != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/342x200.png',
                                  image: bannerList[index].image,
                                  width: DeviceInfo(context).width,
                                  fit: BoxFit.cover,
                                )
                              : CommonWidget.noData,
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          isSlider! == false
                              ? store.dispatch(
                                  SetExploreSecondBannerCarouselIndex(
                                      payload: index))
                              : store.dispatch(
                                  SetExploreFirstBannerCarouselIndex(
                                      payload: index));
                        },
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        viewportFraction: 0.9,
                        autoPlay: true,
                      ),
                    )
                  : CommonWidget.noData,
        ),
        Positioned(
          bottom: 10,
          child: MyAnimatedSmoothIndicator(
              carouselIndex: carouselIndex,
              images: bannerList ?? 0 as List<dynamic>),
        )
      ],
    );
  }
}

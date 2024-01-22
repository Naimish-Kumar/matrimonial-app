import 'package:active_matrimonial_flutter_app/components/shades.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/style.dart';
import '../helpers/navigator_push.dart';
import '../redux/libs/explore/explore_action.dart';
import '../screens/core.dart';
import '../screens/happy_story/happy_stories_details.dart';
import 'common_widget.dart';

class HappyStoriesCard extends StatelessWidget {
  final bool? isFetching;
  final List? happyStories;
  final CarouselController? controller;
  final happyStoriesIndex;

  const HappyStoriesCard(
      {super.key,
      this.isFetching,
      this.happyStories,
      this.controller,
      this.happyStoriesIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 235,
          child: isFetching!
              ? CommonWidget.circularIndicator
              : happyStories!.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: happyStories!.length,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            NavigatorPush.push(
                              context,
                              HappyStoriesDetails(
                                data: happyStories![index],
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          happyStories![index].thumbImg),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                              ),
                              Shades.transparent_dark(),
                              // title and subtitle of the happy stories
                              Positioned(
                                bottom: 15,
                                right: 0,
                                left: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // named row
                                      Text(
                                        happyStories![index].title,
                                        style: Styles.bold_white_16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      //member id row
                                      Text(
                                        happyStories![index].details,
                                        style: Styles.regular_light_grey_12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          store.dispatch(
                            SetExploreHappyStoriesCarouselIndex(payload: index),
                          );
                        },
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                    )
                  : CommonWidget.noData,
        ),
        Positioned(
          bottom: 12,
          child: AnimatedSmoothIndicator(
            effect: ExpandingDotsEffect(
                dotColor: Colors.white.withOpacity(0.3),
                activeDotColor: Colors.white.withOpacity(0.2),
                dotHeight: 8,
                dotWidth: 8),
            activeIndex: happyStoriesIndex,
            count: happyStories!.length ?? 0,
          ),
        )
      ],
    );
  }
}

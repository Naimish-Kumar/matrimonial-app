import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HappyStories extends StatefulWidget {
  const HappyStories({Key? key}) : super(key: key);

  @override
  State<HappyStories> createState() => _HappyStoriesState();
}

class _HappyStoriesState extends State<HappyStories> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.dispatch(Reset.happyStories);
    store.dispatch(happyStoriesMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.happyStoriesState!.hasMore!) {
          store.dispatch(happyStoriesMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
              text:
                  AppLocalizations.of(context)!.happy_story_screen_appbar_title)
          .build(context),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => state.happyStoriesState!.isFetching!
            ? CommonWidget.circularIndicator
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal, vertical: 10),
                child: buildBody(context, state),
              ),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return SizedBox(
      height: DeviceInfo(context).height,
      child: state.happyStoriesState!.happyStoriesList!.isNotEmpty
          ? MasonryGridView.count(
              controller: scrollController,
              itemCount: state.happyStoriesState!.happyStoriesList!.length + 1,
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              itemBuilder: (context, index) {
                if (index < state.happyStoriesState!.happyStoriesList!.length) {
                  return InkWell(
                    onTap: () {
                      NavigatorPush.push(
                        context,
                        HappyStoriesDetails(
                          data:
                              state.happyStoriesState!.happyStoriesList![index],
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: DeviceInfo(context).width! / 2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            child: MyImages.normalImage(state.happyStoriesState!
                                .happyStoriesList![index].thumbImg),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.4,
                                    0.8,
                                  ],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                        ),
                        Const.height10,
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index.isOdd
                                    ? Text(
                                        state.happyStoriesState!
                                            .happyStoriesList![index].title,
                                        maxLines: 1,
                                        style: Styles.bold_white_14,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        state.happyStoriesState!
                                            .happyStoriesList![index].title,
                                        maxLines: 2,
                                        style: Styles.bold_white_14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${AppLocalizations.of(context)!.happy_stories_posted_by} ${state.happyStoriesState!.happyStoriesList![index].userFirstName} ${state.happyStoriesState!.happyStoriesList![index].userLastName}",
                                  style: Styles.regular_gull_grey_10,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  "${AppLocalizations.of(context)!.happy_stories_on} ${state.happyStoriesState!.happyStoriesList![index].date}",
                                  style: Styles.regular_gull_grey_10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: state.happyStoriesState!.hasMore!
                          ? CircularProgressIndicator(
                              color: MyTheme.storm_grey,
                            )
                          : const Text('No more data'),
                    ),
                  );
                }
              },
            )
          : CommonWidget.noData,
    );
  }
}

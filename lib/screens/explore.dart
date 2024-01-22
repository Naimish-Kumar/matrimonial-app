import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/package_card.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blogs.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/banner_widget.dart';
import '../components/blog_card.dart';
import '../components/custom_popup.dart';
import '../components/happy_stories_card.dart';
import '../components/member_card.dart';
import '../components/trusted_user_card.dart';
import '../models_response/Explore/review_response.dart';
import '../redux/libs/explore/explore_middleware.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool isLogin = store.state.authState?.userData?.id != null;
  //prefs.getBool("isLogin") ?? false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExploreViewModel>(
      converter: (store) => ExploreViewModel.fromStore(store),
      onInit: (store) => [
        store.dispatch(fetchSliderAction()),
        store.dispatch(fetchPremiumMembersAction()),
        store.dispatch(fetchBannerAction()),
        store.dispatch(fetchTrustedByAction()),
        store.dispatch(fetchNewMembersAction()),
        store.dispatch(fetchHappyStoriesAction()),
        store.dispatch(fetchPackagesAction()),
        store.dispatch(fetchReviewAction()),
        store.dispatch(fetchBlogsAction()),
      ],
      builder: (_, ExploreViewModel vm) {
        return Scaffold(
          appBar: buildAppBar(context),
          body: Builder(
            builder: (context) {
              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    store.dispatch(fetchSliderAction());
                    store.dispatch(fetchPremiumMembersAction());
                    store.dispatch(fetchBannerAction());
                    store.dispatch(fetchTrustedByAction());
                    store.dispatch(fetchNewMembersAction());
                    store.dispatch(fetchHappyStoriesAction());
                    store.dispatch(fetchPackagesAction());
                    store.dispatch(fetchReviewAction());
                    store.dispatch(fetchBlogsAction());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildFirstBanner(context, vm),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Const.kPaddingHorizontal,
                              vertical: Const.kPaddingVertical),
                          child: buildFindBestFriend(context),
                        ),
                        if (settingIsActive(
                            "show_premium_member_section", "on"))
                          buildPremiumMembers(context, vm),
                        buildSecondBanner(context, vm),
                        buildTrustedByUsers(context, vm),
                        buildNewMembers(context, vm),
                        buildHappyStories(context, vm),
                        buildPackages(context, vm),
                        buildReview(context, vm),
                        buildBlogSection(context, vm),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  buildBlogSection(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // blog section
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Const.kPaddingHorizontal,
                ),
                child: InkWell(
                  onTap: () {
                    NavigatorPush.push(context, const BlogPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.home_9_blog_section,
                        style: Styles.bold_app_accent_22,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Image.asset(
                          'assets/icon/icon_right.png',
                          color: MyTheme.gull_grey,
                          height: 15,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogCard(
                isFetching: vm.isFetchingBlog!,
                blogList: vm.blogs!,
              )
            ],
          ),
        )
      ],
    );
  }

  buildReview(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context)!.home_9_real_reviews,
            style: Styles.bold_app_accent_22,
          ),
        ),
        // real reviews
        const SizedBox(
          height: 10,
        ),

        Container(
          height: 357,
          width: DeviceInfo(context).width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/real_review_back_img.png'),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: vm.reviews != null
                    ? MyImages.normalImage(vm.reviews?.bgImage)
                    : Const.heightShrink,
              ),
              vm.isFetchingReview!
                  ? CommonWidget.circularIndicator
                  : vm.reviews != null
                      ? CarouselSlider.builder(
                          carouselController: vm.reviewController,
                          itemCount: vm.reviews!.items!.length,
                          itemBuilder: (context, index, realIndex) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 18, bottom: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 44,
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45.0),
                                      child: SizedBox(
                                        width: 77,
                                        height: 77,
                                        child: MyImages.normalImage(
                                            vm.reviews?.items?[index].image),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      vm.reviews!.items![index].review!,
                                      textAlign: TextAlign.center,
                                      style: Styles.italic_white_14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    'assets/icon/icon_qoute.png',
                                    height: 35,
                                  ),
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: DeviceInfo(context).height,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 10),
                            viewportFraction: 1,
                            autoPlay: true,
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
              // other widgets in the stack
            ],
          ),
        ),
      ],
    );
  }

  buildNewMembers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context)!.home_9_new_members,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MemberCard(
          isLogin: isLogin,
          isFetching: vm.isFetchingNewMembers!,
          memberList: vm.newMemberList!,
          controller: vm.pageController,
          isProfileView: vm.isFullProfileView!,
          memberType: vm.myMembershipType.toString(),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildHappyStories(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            NavigatorPush.push(context, const HappyStories());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.home_9_happy_stories,
                  style: Styles.bold_app_accent_22,
                ),
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Image.asset(
                    'assets/icon/icon_right.png',
                    color: MyTheme.gull_grey,
                    height: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        HappyStoriesCard(
          isFetching: vm.isFetchingHappyStories!,
          happyStories: vm.happyStories!,
          controller: vm.happyStoriesController,
          happyStoriesIndex: vm.happyStoriesIndex!,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildPackages(BuildContext context, ExploreViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context)!.home_9_packages,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PackageCard(
          isFetching: vm.isFetchingPackages!,
          packageList: vm.packages!,
          isLogin: isLogin,
          profilePicturePrivacy: vm.profilePicturePrivacy!,
          galleryPicturePrivacy: vm.galleryPicturePrivacy!,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildTrustedByUsers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: Const.kPaddingHorizontal, left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context)!.home_9_trusted_by_users,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TrustedUserCard(
          isFetching: vm.isFetchingTrustBy!,
          cardList: vm.trustedByList!,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildSecondBanner(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        BannerWidget(
          isSlider: false,
          isFetching: vm.isFetchingBanner!,
          bannerList: vm.bannerList!,
          carouselIndex: vm.carouselIndex2,
          controller: vm.carouselController2,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildPremiumMembers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            getSettingValue("premium_member_section_title"),
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // image stack premium members #### premium members
        MemberCard(
          isLogin: isLogin,
          isFetching: vm.isFetchingPremiumMembers!,
          memberList: vm.premiumMembersList!,
          controller: vm.pageController,
          isProfileView: vm.isFullProfileView!,
          memberType: vm.myMembershipType.toString(),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildFindBestFriend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.landing_page_title,
          style: Styles.bold_app_accent_30,
        ),
        const SizedBox(
          height: 10,
        ),
        // let's find your life partner to enjoy every moment of your life
        Text(
          AppLocalizations.of(context)!.landing_page_sub_title,
          style: Styles.regular_arsenic_14,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildFirstBanner(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        BannerWidget(
          isSlider: true,
          isFetching: vm.isFetchingSlider!,
          bannerList: vm.sliderImages!,
          carouselIndex: vm.carouselIndex,
          controller: vm.carouselController,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                    isLogin
                        ? NavigatorPush.push(context, const Notifications())
                        : CustomPopUp(context).loginDialog(context);
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
                    isLogin
                        ? showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const SizedBox(
                                  height: 1000, child: Search());
                            },
                          )
                        : CustomPopUp(context).loginDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreViewModel {
  bool? isFullProfileView;
  var myMembershipType;
  bool? profilePicturePrivacy;
  bool? galleryPicturePrivacy;
  String? error;
  int? carouselIndex;
  int? carouselIndex2;
  int? happyStoriesIndex;
  final carouselController;
  final carouselController2;
  final happyStoriesController;
  final reviewController;
  final pageController;
  bool? isFetchingSlider;
  List? sliderImages;
  bool? isFetchingPremiumMembers;
  List<MemberData>? premiumMembersList;
  bool? isFetchingBanner;
  List? bannerList;
  bool? isFetchingTrustBy;
  List? trustedByList;
  bool? isFetchingNewMembers;
  List<MemberData>? newMemberList;
  bool? isFetching;
  bool? isFetchingPackages;
  List? packages;
  bool? isFetchingHappyStories;
  List? happyStories;

  bool? isFetchingReview;
  ReviewData? reviews;
  bool? isFetchingBlog;
  List? blogs;
  String? currencyCode;

  ExploreViewModel({
    this.isFetchingBlog,
    this.blogs,
    this.currencyCode,
    this.isFetchingReview,
    this.reviews,
    this.isFetchingPackages,
    this.packages,
    this.isFetchingHappyStories,
    this.happyStories,
    this.isFetchingNewMembers,
    this.newMemberList,
    this.isFetchingTrustBy,
    this.trustedByList,
    this.isFetchingBanner,
    this.bannerList,
    this.isFetchingPremiumMembers,
    this.premiumMembersList,
    this.isFetchingSlider,
    this.sliderImages,
    this.pageController,
    this.reviewController,
    this.happyStoriesController,
    this.happyStoriesIndex,
    this.carouselController,
    this.carouselController2,
    this.carouselIndex,
    this.carouselIndex2,
    this.error,
    this.isFetching,
    this.isFullProfileView,
    this.myMembershipType,
    this.profilePicturePrivacy,
    this.galleryPicturePrivacy,
  });

  static fromStore(Store<AppState> store) {
    return ExploreViewModel(
        isFullProfileView:
            settingIsActive("full_profile_show_according_to_membership", "1"),
        myMembershipType: store.state.packageDetailsState!.data?.name,
        profilePicturePrivacy:
            settingIsActive("profile_picture_privacy", "only_me"),
        galleryPicturePrivacy:
            settingIsActive("gallery_image_privacy", "only_me"),
        error: store.state.exploreState!.error,
        isFetching: store.state.exploreState!.isFetching,
        carouselIndex: store.state.exploreState!.carouselIndex,
        carouselIndex2: store.state.exploreState!.carouselIndex2,
        carouselController: store.state.exploreState!.carouselController,
        carouselController2: store.state.exploreState!.carouselController2,
        happyStoriesIndex: store.state.exploreState!.happyStoriesIndex,
        happyStoriesController:
            store.state.exploreState!.happyStoriesController,
        reviewController: store.state.exploreState!.reviewController,
        pageController: store.state.exploreState!.pageController,
        //slider
        isFetchingSlider: store.state.exploreState!.isFetchingSlider,
        sliderImages: store.state.exploreState!.sliderImageList,
        // premium members
        isFetchingPremiumMembers:
            store.state.exploreState!.isFetchingPremiumMembers,
        premiumMembersList: store.state.exploreState!.premiumMemberList,
        //banner
        isFetchingBanner: store.state.exploreState!.isFetchingBanner,
        bannerList: store.state.exploreState!.bannerList,

        // trusted by
        isFetchingTrustBy: store.state.exploreState!.isFetchingTrustedBy,
        trustedByList: store.state.exploreState!.trustedByList,
        isFetchingNewMembers: store.state.exploreState!.isFetchingNewMembers,
        newMemberList: store.state.exploreState!.newMemberList,

        // happy stories
        isFetchingHappyStories:
            store.state.exploreState!.isFetchingHappyStories,
        happyStories: store.state.exploreState!.happyStoriesList,
        isFetchingPackages: store.state.exploreState!.isFetchingPackage,
        packages: store.state.exploreState!.packageList,
        isFetchingReview: store.state.exploreState!.isFetchingReview,
        reviews: store.state.exploreState!.review,
        isFetchingBlog: store.state.exploreState!.isFetchingBlog,
        blogs: store.state.exploreState!.blogList,
        currencyCode: getSettingValue("system_default_currency"));
  }
}

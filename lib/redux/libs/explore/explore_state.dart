import 'package:active_matrimonial_flutter_app/models_response/Explore/new_members_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/premium_member_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../models_response/Explore/review_response.dart';

class ExploreState {
  bool? isFetching;
  String? error;
  int? carouselIndex;
  int? carouselIndex2;
  int? happyStoriesIndex;
  CarouselController? carouselController = CarouselController();
  CarouselController? carouselController2 = CarouselController();
  CarouselController? happyStoriesController = CarouselController();
  CarouselController? reviewController = CarouselController();
  PageController? pageController = PageController();
// slider
  bool? isFetchingSlider;
  List? sliderImageList = [];
  String? sliderError;

  bool? isFetchingBlog;
  List<dynamic>? blogList = [];
  String? blogError;

  bool? isFetchingNewMembers;
  List<MemberData>? newMemberList = [];
  String? newMemberError;
// premium members
  bool? isFetchingPremiumMembers;
  List<MemberData>? premiumMemberList = [];
  String? premiumMembersError;
//banner
  bool? isFetchingBanner;
  List? bannerList = [];
  String? bannerError;

  bool? isFetchingTrustedBy;
  List<dynamic>? trustedByList = [];

  String? trustedByError;
  bool? isFetchingHappyStories;
  List<dynamic>? happyStoriesList = [];

  String? happyStoriesError;
  bool? isFetchingPackage;
  List<dynamic>? packageList = [];

  String? packageError;
  bool? isFetchingReview;
  ReviewData? review;
  String? reviewError;

  ExploreState({
    this.isFetching,
    this.error,
    this.carouselIndex,
    this.carouselIndex2,
    this.happyStoriesIndex,
    this.carouselController,
    this.carouselController2,
    this.happyStoriesController,
    this.reviewController,
    this.pageController,
    this.isFetchingSlider,
    this.sliderImageList,
    this.sliderError,
    this.isFetchingBlog,
    this.blogList,
    this.blogError,
    this.isFetchingNewMembers,
    this.newMemberList,
    this.newMemberError,
    this.isFetchingPremiumMembers,
    this.premiumMemberList,
    this.premiumMembersError,
    this.isFetchingBanner,
    this.bannerList,
    this.bannerError,
    this.isFetchingTrustedBy,
    this.trustedByList,
    this.trustedByError,
    this.isFetchingHappyStories,
    this.happyStoriesList,
    this.happyStoriesError,
    this.isFetchingPackage,
    this.packageList,
    this.packageError,
    this.isFetchingReview,
    this.review,
    this.reviewError,
  });

  ExploreState.initialState()
      : isFetching = true,
        error = '',
        isFetchingSlider = true,
        sliderError = '',
        sliderImageList = [],
        isFetchingBlog = true,
        blogError = '',
        blogList = [],
        isFetchingNewMembers = true,
        newMemberList = [],
        newMemberError = '',
        isFetchingPremiumMembers = true,
        premiumMembersError = '',
        premiumMemberList = [],
        isFetchingBanner = true,
        bannerList = [],
        bannerError = '',
        isFetchingTrustedBy = true,
        trustedByList = [],
        trustedByError = '',
        isFetchingHappyStories = true,
        happyStoriesList = [],
        happyStoriesError = '',
        isFetchingPackage = true,
        packageList = [],
        packageError = '',
        isFetchingReview = true,
        review = null,
        reviewError = '',
        carouselIndex = 0,
        carouselIndex2 = 0,
        happyStoriesIndex = 0;
}

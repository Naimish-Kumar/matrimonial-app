import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_state.dart';

ExploreState? explore_reducer(ExploreState? state, action) {
  if (action == Reset.exploreList) {
    state = ExploreState.initialState();
    return state;
  }

  //slider
  if (action is SliderStoreAction) {
    state!.isFetchingSlider = false;
    state.sliderImageList = action.payload!.data;
    return state;
  }
  if (action is SliderFailureAction) {
    state!.sliderError = action.error;
    return state;
  }
  // premium members
  if (action is PremiumMembersStoreAction) {

    state!.isFetchingPremiumMembers = false;
    state.premiumMemberList = action.payload!.data;
    print("state.premiumMemberList.length");
    print(state.premiumMemberList!.length);
    return state;
  }
  if (action is PremiumMembersFailureAction) {
    print("PremiumMembersFailureAction");
    state!.premiumMembersError = action.error;
    return state;
  }

  // banner
  if (action is BannerStoreAction) {
    state!.isFetchingBanner = false;
    state.bannerList = action.payload!.data;
    return state;
  }
  if (action is BannerFailureAction) {
    state!.bannerError = action.error;
    return state;
  }

  // trusted by millions
  if (action is TrustedByStoreAction) {
    state!.isFetchingTrustedBy = false;
    state.trustedByList = action.payload!.data;
    return state;
  }
  if (action is TrustedByFailureAction) {
    state!.trustedByError = action.error;
    return state;
  }

  // new members
  if (action is NewMembersStoreAction) {
    state!.isFetchingNewMembers = false;
    state.newMemberList = action.payload!.data;
    return state;
  }
  if (action is NewMembersFailureAction) {
    state!.newMemberError = action.error;
    return state;
  }
  // happy stories
  if (action is EHappyStoriesStoreAction) {
    state!.isFetchingHappyStories = false;
    state.happyStoriesList = action.payload!.data;
    return state;
  }
  if (action is EHappyStoriesFailureAction) {
    state!.happyStoriesError = action.error;
    return state;
  }
  // packages
  if (action is PackageStoreAction) {
    state!.isFetchingPackage = false;
    state.packageList = action.payload!.data;
    return state;
  }
  if (action is PackageFailureAction) {
    state!.packageError = action.error;
    return state;
  }

  // review
  if (action is ReviewStoreAction) {
    state!.isFetchingReview = false;
    state.review = action.payload!.data;
    return state;
  }
  if (action is ReviewFailureAction) {
    state!.reviewError = action.error;
    return state;
  }

  // blogs
  if (action is BlogStoreAction) {
    state!.isFetchingBlog = false;
    state.blogList = action.payload!.data;
    return state;
  }
  if (action is BlogFailureAction) {
    state!.blogError = action.error;
    return state;
  }

  // carousel first index set
  if (action is SetExploreFirstBannerCarouselIndex) {
    state!.carouselIndex = action.payload;
    return state;
  }

  // carousel second index set
  if (action is SetExploreSecondBannerCarouselIndex) {
    state!.carouselIndex2 = action.payload;
    return state;
  }
  // set happy stories carousel set
  if (action is SetExploreHappyStoriesCarouselIndex) {
    state!.happyStoriesIndex = action.payload;
    return state;
  }

  return state;
}

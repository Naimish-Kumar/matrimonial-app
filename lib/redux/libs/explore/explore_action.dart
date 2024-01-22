import 'package:active_matrimonial_flutter_app/models_response/Explore/banner_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/blogs_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/e_happy_stories_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/new_members_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/package_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/review_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/slider_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/Explore/trusted_by_millions_response.dart';

import '../../../models_response/Explore/premium_member_response.dart';

// slider action
class SliderStoreAction {
  SliderResponse? payload;

  SliderStoreAction({this.payload});

  @override
  String toString() {
    return 'SliderStoreAction{payload: $payload}';
  }
}

class SliderFailureAction {
  String? error;

  SliderFailureAction({this.error});

  @override
  String toString() {
    return 'SliderFailureAction{payload: $error}';
  }
}

// premium members action
class PremiumMembersStoreAction {
  PremiumMembersResponse? payload;

  PremiumMembersStoreAction({this.payload});

  @override
  String toString() {
    return 'PremiumMembersStoreAction{payload: $payload}';
  }
}

class PremiumMembersFailureAction {
  String? error;

  PremiumMembersFailureAction({this.error});

  @override
  String toString() {
    return 'PremiumMembersFailureAction{error: $error}';
  }
}

// banner
class BannerStoreAction {
  BannerResponse? payload;

  BannerStoreAction({this.payload});

  @override
  String toString() {
    return 'BannerStoreAction{payload: $payload}';
  }
}

class BannerFailureAction {
  String? error;

  BannerFailureAction({this.error});

  @override
  String toString() {
    return 'BannerFailureAction{error: $error}';
  }
}

// trusted by
class TrustedByStoreAction {
  TrustedByMillionsResponse? payload;

  TrustedByStoreAction({this.payload});

  @override
  String toString() {
    return 'TrustedByStoreAction{payload: $payload}';
  }
}

class TrustedByFailureAction {
  String? error;

  TrustedByFailureAction({this.error});

  @override
  String toString() {
    return 'TrustedByFailureAction{error: $error}';
  }
}

// new members action
class NewMembersStoreAction {
  NewMembersResponse? payload;

  NewMembersStoreAction({this.payload});

  @override
  String toString() {
    return 'NewMembersStoreAction{payload: $payload}';
  }
}

class NewMembersFailureAction {
  String? error;

  NewMembersFailureAction({this.error});

  @override
  String toString() {
    return 'NewMembersFailureAction{error: $error}';
  }
}

// happy stories

class EHappyStoriesStoreAction {
  EHappyStoriesResponse? payload;

  EHappyStoriesStoreAction({this.payload});

  @override
  String toString() {
    return 'EHappyStoriesStoreAction{payload: $payload}';
  }
}

class EHappyStoriesFailureAction {
  String? error;

  EHappyStoriesFailureAction({this.error});

  @override
  String toString() {
    return 'EHappyStoriesFailureAction{payload: $error}';
  }
}

// package members action
class PackageStoreAction {
  PackageResponse? payload;

  PackageStoreAction({this.payload});

  @override
  String toString() {
    return 'PackageStoreAction{payload: $payload}';
  }
}

class PackageFailureAction {
  String? error;

  PackageFailureAction({this.error});

  @override
  String toString() {
    return 'PackageFailureAction{error: $error}';
  }
}

// review members action
class ReviewStoreAction {
  ReviewResponse? payload;

  ReviewStoreAction({this.payload});

  @override
  String toString() {
    return 'ReviewStoreAction{payload: $payload}';
  }
}

class ReviewFailureAction {
  String? error;

  ReviewFailureAction({this.error});

  @override
  String toString() {
    return 'ReviewFailureAction{error: $error}';
  }
}

// blog section

class BlogStoreAction {
  BlogsResponse? payload;

  BlogStoreAction({this.payload});

  @override
  String toString() {
    return 'BlogStoreAction{payload: $payload}';
  }
}

class BlogFailureAction {
  String? error;

  BlogFailureAction({this.error});

  @override
  String toString() {
    return 'BlogFailureAction{error: $error}';
  }
}

class SetExploreFirstBannerCarouselIndex {
  int? payload;

  SetExploreFirstBannerCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreFirstBannerCarouselIndex{payload: $payload}';
  }
}

class SetExploreSecondBannerCarouselIndex {
  int? payload;

  SetExploreSecondBannerCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreSecondBannerCarouselIndex{payload: $payload}';
  }
}

class SetExploreHappyStoriesCarouselIndex {
  int? payload;

  SetExploreHappyStoriesCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreHappyStoriesCarouselIndex{payload: $payload}';
  }
}

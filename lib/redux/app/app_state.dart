import 'package:active_matrimonial_flutter_app/redux/libs/account/account_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/forgetpassword_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/vertify_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/blog/blog_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_us/contact_us_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_view/contact_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/lading_page/landing.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/manage_profile_combine_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/member_info/member_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/my_happy_story_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_details_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/premium_plans/premium_plans_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/basic_search_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/staticPage/static_page.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket_create/support_ticket_create_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_state.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';
import 'package:flutter/material.dart';

import '../libs/auth/authstate.dart';
import '../libs/common/common_state.dart';
import '../libs/interest/interest_request_state.dart';
import '../libs/offline_payment/offline_payment_state.dart';
import '../libs/verify/verify_state.dart';
import '../libs/wallet/package_payment_with_wallet.dart';

@immutable
class AppState {
  final UserVerifyState? userVerifyState;
  final StaticPageState? staticPageState;
  final ContactUsState? contactUsState;
  final MatchedProfileState? matchedProfileState;
  final MemberInfoState? memberInfoState;
  final PictureProfileViewState? pictureProfileViewState;
  final GalleryPictureViewState? galleryPictureViewState;
  final AddonState? addonState;
  final ChatDetailsState? chatDetailsState;
  final ShowMessageState? showMessageState;
  final SignUpState? signUpState;
  final AuthState? authState;
  final LandingState? landingState;
  final BasicSearchState? basicSearchState;
  final SignInState? signInState;
  final NotificationState? notificationState;
  final ReferralState? referralState;
  final ForgetPasswordState? forgetPasswordState;
  final VerifyState? verifyState;
  final SignOutState? signOutState;
  final ResetPasswordState? resetPasswordState;
  final AccountState? accountState;
  final BlogState? blogState;
  final ExploreState? exploreState;
  final HomeState? homeState;
  final MyInterestState? myInterestState;
  final InterestRequestState? interestRequestState;
  final ShortlistState? shortlistState;
  final HappyStoriesState? happyStoriesState;
  final ChatState? chatState;
  final GalleryImageState? galleryImageState;
  final PackageState? packageState;
  final IgnoreState? ignoreState;
  final AppInfoState? appInfoState;
  final MyWalletState? myWalletState;
  final MyHappyStoryState? myHappyStoryState;
  final SupportTicketState? supportTicketState;
  final ManageProfileCombineState? manageProfileCombineState;
  final PublicProfileState? publicProfileState;
  final PaymentTypesState? paymentTypesState;
  final PremiumPlansState? premiumPlansState;
  final ChangePasswordState? changePasswordState;
  final PackageDetailsState? packageDetailsState;
  final ReferralEarningState? referralEarningState;
  final SystemSettingState? systemSettingState;
  final ContactViewState? contactViewState;
  final SupportTicketCreateState? supportTicketCreateState;
  final SupportTicketReplyState? supportTicketReplyState;
  final ReferralWithdrawRequestHistoryState?
      referralWithdrawRequestHistoryState;
  final PackagePaymentWithWalletState? packagePaymentWithWalletState;
  CommonState? commonState;
  final OfflinePaymentState? offlinePaymentState;

  AppState(
      {this.staticPageState,
      this.userVerifyState,
      this.contactUsState,
      this.offlinePaymentState,
      this.packagePaymentWithWalletState,
      this.memberInfoState,
      this.matchedProfileState,
      this.signUpState,
      this.landingState,
      this.galleryPictureViewState,
      this.referralWithdrawRequestHistoryState,
      this.contactViewState,
      this.supportTicketCreateState,
      this.referralEarningState,
      this.supportTicketReplyState,
      this.pictureProfileViewState,
      this.addonState,
      this.chatDetailsState,
      this.systemSettingState,
      this.changePasswordState,
      this.appInfoState,
      this.interestRequestState,
      this.packageDetailsState,
      this.premiumPlansState,
      this.paymentTypesState,
      this.showMessageState,
      this.basicSearchState,
      this.notificationState,
      this.publicProfileState,
      this.supportTicketState,
      this.myWalletState,
      this.myHappyStoryState,
      this.packageState,
      this.galleryImageState,
      this.referralState,
      this.signInState,
      this.forgetPasswordState,
      this.verifyState,
      this.manageProfileCombineState,
      this.signOutState,
      this.resetPasswordState,
      this.accountState,
      this.blogState,
      this.exploreState,
      this.homeState,
      this.myInterestState,
      this.shortlistState,
      this.happyStoriesState,
      this.ignoreState,
      this.chatState,
      this.authState,
      this.commonState});

  AppState.initialState()
      : signUpState = SignUpState.initialState(),
        userVerifyState = UserVerifyState.initialState(),
        offlinePaymentState = OfflinePaymentState.initialState(),
        staticPageState = StaticPageState.initialState(),
        contactUsState = ContactUsState.initialState(),
        packagePaymentWithWalletState =
            PackagePaymentWithWalletState.initialState(),
        memberInfoState = MemberInfoState.initialState(),
        matchedProfileState = MatchedProfileState.initialState(),
        addonState = AddonState.initialState(),
        landingState = LandingState.initialState(),
        galleryPictureViewState = GalleryPictureViewState.initial(),
        supportTicketCreateState = SupportTicketCreateState.initialState(),
        supportTicketReplyState = SupportTicketReplyState.initialState(),
        contactViewState = ContactViewState.initialState(),
        referralWithdrawRequestHistoryState =
            ReferralWithdrawRequestHistoryState.initialState(),
        showMessageState = ShowMessageState.initialState(),
        pictureProfileViewState = PictureProfileViewState.initial(),
        systemSettingState = SystemSettingState.initialState(),
        packageDetailsState = PackageDetailsState.initialState(),
        changePasswordState = ChangePasswordState.initialState(),
        referralEarningState = ReferralEarningState.initialState(),
        chatDetailsState = ChatDetailsState.initialState(),
        paymentTypesState = PaymentTypesState.initialState(),
        interestRequestState = InterestRequestState.initialState(),
        premiumPlansState = PremiumPlansState.initialState(),
        referralState = ReferralState.initialState(),
        notificationState = NotificationState.initialState(),
        appInfoState = AppInfoState.initialState(),
        basicSearchState = BasicSearchState.initialState(),
        supportTicketState = SupportTicketState.initialState(),
        publicProfileState = PublicProfileState.initialState(),
        myWalletState = MyWalletState.initialState(),
        myHappyStoryState = MyHappyStoryState.initialState(),
        signInState = SignInState.initialState(),
        galleryImageState = GalleryImageState.initialState(),
        forgetPasswordState = ForgetPasswordState.initialState(),
        verifyState = VerifyState.initialState(),
        signOutState = SignOutState.initialState(),
        manageProfileCombineState = ManageProfileCombineState.initialState(),
        resetPasswordState = ResetPasswordState.initialState(),
        accountState = AccountState.initialState(),
        blogState = BlogState.initialState(),
        exploreState = ExploreState.initialState(),
        homeState = HomeState.initialState(),
        packageState = PackageState.initialState(),
        ignoreState = IgnoreState.initialState(),
        myInterestState = MyInterestState.initialState(),
        shortlistState = ShortlistState.initialState(),
        happyStoriesState = HappyStoriesState.initialState(),
        authState = null,
        commonState = CommonState(),
        chatState = ChatState.initialState();
}

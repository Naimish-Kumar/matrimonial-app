import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_api_request.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/forgetpassword_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/verify_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/blog/blog_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_view/contact_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/lading_page/landing.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/manage_profile_combine_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/my_happy_story_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/offline_payment/offline_payment_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_details_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/premium_plans/premium_plans_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_earning_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/basic_search_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/staticPage/static_page.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket_create/support_ticket_create_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/my_wallet_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/package_payment_with_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';

import '../libs/add_on/addon_reducer.dart';
import '../libs/common/common_states_reducer.dart';
import '../libs/contact_us/contact_us_reducer.dart';
import '../libs/matched_profile/matched_profile_reducer.dart';
import '../libs/member_info/member_info.dart';
import '../libs/verify/verify_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  var accessToken = prefs.getString(Const.accessToken);
  AizApi.get(Uri.parse("${AppConfig.BASE_URL}/app-check"), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $accessToken",
  });

  return AppState(
      signUpState: sign_up_reducer(state.signUpState, action),
      userVerifyState: userVerifyReducer(state.userVerifyState!, action),
      offlinePaymentState:
          offlinePaymentReducer(state.offlinePaymentState, action),
      contactUsState: contact_us_reducer(state.contactUsState, action),
      packagePaymentWithWalletState:
          ppwws_reducer(state.packagePaymentWithWalletState, action),
      staticPageState: staticPageReducer(state.staticPageState, action),
      showMessageState: show_message_reducer(state.showMessageState, action),
      memberInfoState: member_info_reducer(state.memberInfoState, action),
      matchedProfileState:
          matched_profile_state(state.matchedProfileState, action),
      publicProfileState:
          public_profile_reducer(state.publicProfileState, action),
      contactViewState: contact_view_reducer(state.contactViewState, action),
      paymentTypesState: payment_types_reducer(state.paymentTypesState, action),
      signInState: sign_in_reducer(state.signInState, action),
      referralEarningState:
          referralEarningReducer(state.referralEarningState, action),
      packageDetailsState:
          package_details_reducer(state.packageDetailsState, action),
      forgetPasswordState:
          forgetpassword_reducer(state.forgetPasswordState, action),
      premiumPlansState: premium_plans_reducer(state.premiumPlansState, action),
      basicSearchState: basic_search_reducer(state.basicSearchState, action),
      referralState: referral_reducer(state.referralState, action),
      landingState: landingReducer(state.landingState, action),
      verifyState: verify_reducer(state.verifyState, action),
      chatDetailsState: chat_details_reducer(state.chatDetailsState, action),
      appInfoState: app_info_reducer(state.appInfoState, action),
      changePasswordState:
          change_password_reducer(state.changePasswordState, action),
      signOutState: sign_out_reducer(state.signOutState, action),
      manageProfileCombineState: manage_profile_combine_reducer(
          state.manageProfileCombineState, action),
      referralWithdrawRequestHistoryState:
          referral_withdraw_request_history_reducer(
              state.referralWithdrawRequestHistoryState, action),
      notificationState: notification_reducer(state.notificationState, action),
      myWalletState: my_wallet_reducer(state.myWalletState, action),
      myHappyStoryState:
          my_happy_story_reducer(state.myHappyStoryState, action),
      supportTicketState:
          support_ticket_reducer(state.supportTicketState, action),
      resetPasswordState:
          reset_password_reducer(state.resetPasswordState, action),
      galleryImageState: gallery_image_reducer(state.galleryImageState, action),
      accountState: account_reducer(state.accountState, action),
      blogState: blog_reducer(state.blogState, action),
      exploreState: explore_reducer(state.exploreState, action),
      homeState: home_reducer(state.homeState, action),
      packageState: package_reducer(state.packageState, action),
      myInterestState: my_interest_reducer(state.myInterestState, action),
      interestRequestState:
          interest_request_reducer(state.interestRequestState, action),
      shortlistState: shortlist_reducer(state.shortlistState, action),
      ignoreState: ignore_reducer(state.ignoreState, action),
      systemSettingState: feature_reducer(state.systemSettingState, action),
      addonState: addon_reducer(state.addonState, action),
      happyStoriesState: happy_stories_reducer(state.happyStoriesState, action),
      chatState: chat_reducer(state.chatState, action),
      supportTicketCreateState:
          support_ticket_create_reducer(state.supportTicketCreateState, action),
      supportTicketReplyState:
          support_ticket_reply_reducer(state.supportTicketReplyState, action),
      galleryPictureViewState:
          gallery_picture_view_reducer(state.galleryPictureViewState, action),
      pictureProfileViewState:
          profile_picture_view_reducer(state.pictureProfileViewState, action),
      authState: authReducer(state.authState, action),
      commonState: commonStateCountryReducer(state.commonState, action));
}

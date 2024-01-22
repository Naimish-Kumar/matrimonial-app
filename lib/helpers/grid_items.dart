import 'package:active_matrimonial_flutter_app/components/grid_square_card.dart';
import 'package:active_matrimonial_flutter_app/helpers/localization.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/middleware/check_package_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blogs.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_list.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_shortlist.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/gallery_picture_view_rqst.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/profile_picture_view_rqst.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earnings.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earnings_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';

class GridItems {
  List<dynamic> _menuList = [];

  void addMenu() {
    return _menuList.addAll([
      if (settingIsActive("wallet_system", "1"))
        GridSquareCard(
          onpressed: MyWallet(),
          icon: "icon_wallet.png",
          isSmallScreen: false,
          text: "My Wallet",
        ),
      GridSquareCard(
        onpressed: ChatList(
          backButtonAppearance: true,
        ),
        icon: "icon_messages.png",
        isSmallScreen: false,
        text: "Messages",
      ),
      GridSquareCard(
        onpressed: const Notifications(),
        icon: "icon_notifications.png",
        isSmallScreen: false,
        text: "Notifications",
      ),
      GridSquareCard(
        onpressed: const MyInterest(),
        icon: "icon_love.png",
        isSmallScreen: false,
        text: "My Interest",
      ),
      if (settingIsActive("profile_picture_privacy", "only_me"))
        GridSquareCard(
          onpressed: const PictureProfileViewRqst(),
          icon: "icon_picture_view.png",
          isSmallScreen: false,
          text: LangText(context: OneContext().context)
              .getLocal()!
              .profile_picture_screen_appbar_title,
        ),
      if (settingIsActive("gallery_image_privacy", "only_me"))
        GridSquareCard(
          onpressed: const GalleryProfileViewRqst(),
          icon: "icon_gallery_view.png",
          isSmallScreen: false,
          text: LangText(context: OneContext().context)
              .getLocal()!
              .gallery_picture_screen_appbar_title,
        ),
      GridSquareCard(
        onpressed: const MyShortlist(),
        icon: "icon_shortlist.png",
        isSmallScreen: false,
        text: "My Shortlist",
      ),
      GridSquareCard(
        onpressed: const Ignore(),
        icon: "icon_ignore.png",
        isSmallScreen: false,
        text: "Ignore list",
      ),
      GridSquareCard(
        onpressed: const MyHappyStories(),
        middleware: PackageCheckMiddleware(
            context: OneContext().context!,
            user: store.state.authState!.userData),
        icon: "icon_happy_s.png",
        isSmallScreen: false,
        text: "My happy story",
      ),
      if (settingIsActive("show_blog_section", "on"))
        GridSquareCard(
          onpressed: const BlogPage(),
          icon: "icon_blogs.png",
          isSmallScreen: false,
          text: "Blogs",
        ),
      if (store.state.addonState!.data!.supportTickets!)
        GridSquareCard(
          onpressed: const SupportTicket(),
          icon: "icon_support.png",
          isSmallScreen: false,
          text: "Support Ticket",
        ),
      if (store.state.addonState!.data!.referralSystem!)
        GridSquareCard(
          onpressed: const Referral(),
          icon: "icon_referral_user.png",
          isSmallScreen: false,
          text: "Referral",
        ),
      if (store.state.addonState!.data!.referralSystem!)
        GridSquareCard(
          onpressed: const RefferalEarnings(),
          icon: "icon_referral_earnings.png",
          isSmallScreen: false,
          text: "Ref.. Earnings",
        ),
      if (store.state.addonState!.data!.referralSystem!)
        GridSquareCard(
          onpressed: const ReferralEarningsWallet(),
          icon: "icon_referral_wallet.png",
          isSmallScreen: false,
          text: "Ref.. Wallet",
        ),
    ]);
  }

  dynamic get gridMenuItems => _menuList;
}

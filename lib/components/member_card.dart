import 'package:active_matrimonial_flutter_app/components/shades.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/middleware/profile_view_middleware.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/member_data.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../const/style.dart';
import '../screens/user_pages/user_public_profile.dart';
import 'common_widget.dart';
import 'custom_popup.dart';
import 'my_images.dart';

class MemberCard extends StatelessWidget {
  final bool isFetching;
  final bool isLogin;
  final List<MemberData> memberList;
  final PageController controller;
  final bool isProfileView;
  final String memberType;

  const MemberCard({
    super.key,
    required this.isFetching,
    required this.isLogin,
    required this.memberList,
    required this.controller,
    required this.isProfileView,
    required this.memberType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: isFetching
          ? CommonWidget.circularIndicator
          : memberList.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: memberList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => isLogin
                          ? isProfileView && (memberType == 'Free')
                              ? store.dispatch(ShowMessageAction(
                                  msg: "Please update your package."))
                              : AIZRoute.push(
                                  context,
                                  UserPublicProfile(
                                    userId: memberList[index].userId!,
                                  ),
                                  middleware: ProfileViewMiddleware(
                                      context: context,
                                      user: store.state.authState?.userData))
                          : CustomPopUp(context).loginDialog(context),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 360,
                            width: 220,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: MyImages.normalImage(
                                    memberList[index].photo)),
                          ),
                          Shades.transparent_dark(),
                          Positioned(
                            bottom: 20,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // named row
                                  Text(
                                    memberList[index].name ?? "",
                                    style: Styles.bold_white_16,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  //member id row
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .common_screen_member_id,
                                        style: const TextStyle(
                                            color: MyTheme.white),
                                      ),
                                      Text(memberList[index].code ?? "",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  // age, height, location and full profile row

                                  // page navigator with subscribe, love and follow button
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
    );
  }
}

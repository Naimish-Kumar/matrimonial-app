import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/public_profile_list.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_request_send.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/add_ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/member_info/member_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_request_send.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/add_shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_astronomic_Info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_basic_information.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_career_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_education_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_family_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_hobbies_n_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_introduction.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_language.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_life_style.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_personal_n_attitude.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_pertner_expectation.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_present_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_residency_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_spiritual_n_social.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_usercontact_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../components/common_widget.dart';
import '../../components/full_screen_image_viewer.dart';
import '../../components/navigation_button.dart';
import '../../components/user_profile_action_button.dart';
import '../../redux/libs/report/report_middleware.dart';

class UserPublicProfile extends StatefulWidget {
  final int userId;

  const UserPublicProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPublicProfile> createState() => _UserPublicProfileState();
}

class _UserPublicProfileState extends State<UserPublicProfile> {
  final TextEditingController _reportController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isAuthUser => store.state.authState!.userData!.id == widget.userId;

  expressLove(AppState state) {
    state.accountState!.profileData!.currentPackageInfo!.packageExpiry !=
                "Expired" &&
            store.state.accountState!.profileData!.remainingInterest != 0
        ? store.dispatch(
            expressInterestMiddleware(
              userId: widget.userId,
            ),
          )
        : store.dispatch(ShowMessageAction(
            msg: "Please Upgrade your Package",
          ));
  }

  imageFullView(AppState state, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FullScreenImageViewer(
              state.publicProfileState!.photogallery![index].imagePath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        if (!store.state.userVerifyState!.isApprove!)
          {
            OneContext().pop(),
            store.dispatch(
              ShowMessageAction(
                msg: "Please verify your account",
                color: MyTheme.failure,
              ),
            ),
          }
        else
          {
            store.dispatch(Reset.publicProfile),
            store.dispatch(publicProfileMiddleware(userId: widget.userId)),
            store.dispatch(Reset.memberInfo),
            store.dispatch(memberInfoMiddleware(userId: widget.userId)),
          }
      ],
      builder: (_, state) {
        return DefaultTabController(
          length: (settingIsActive("member_partner_expectation_section", "on"))
              ? 3
              : 2,
          child: Scaffold(
            key: _scaffoldKey,
            body: state.publicProfileState!.isFetching! ||
                    state.memberInfoState!.isFetching!
                ? CommonWidget.circularIndicator
                : Column(
                    children: [
                      buildContainerGradient(context, state),
                      Expanded(
                        child: TabBarView(
                          children: [
                            buildListView(context, state),
                            if (settingIsActive(
                                "member_partner_expectation_section", "on"))
                              const PP_PartnerExpectation(),
                            buildGallery(context, state)
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget buildGallery(mainContext, AppState state) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 10, top: 10.0),
      child: Stack(
        children: [
          MasonryGridView.count(
            padding: EdgeInsets.zero,
            itemCount: state.publicProfileState!.photogallery?.length,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => imageFullView(state, index),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: MyImages.normalImage(
                      state.publicProfileState!.photogallery![index].imagePath),
                ),
              );
            },
          ),
          settingIsActive("gallery_image_privacy", "only_me")
              ? gallery_check(state, mainContext)
              : Container(),
        ],
      ),
    );
  }

  Widget gallery_check(AppState state, mainContext) {
    return Container(
      child: state.memberInfoState?.memberInfo?.galleryViewRequestStatus ==
                  null ||
              state.memberInfoState!.memberInfo!.galleryViewRequestStatus! ||
              state.publicProfileState!.photogallery!.isEmpty
          ? Container()
          : Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/icon_lock.png',
                    color: MyTheme.arsenic,
                    height: 25,
                    width: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      if (!isAuthUser) {
                        sendProfilePicViewRequest(state);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyTheme.light_grey,
                        gradient: !isAuthUser
                            ? Styles.buildLinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)
                            : null,
                      ),
                      child: Text(
                        'Send Gallery Photo View Request',
                        style: Styles.bold_white_12,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  sendProfilePicViewRequest(AppState state) {
    state.accountState!.profileData!.currentPackageInfo!.packageExpiry ==
                "Expired" ||
            state.accountState!.profileData!.remainingGalleryImageView == 0
        ? store.dispatch(ShowMessageAction(
            msg: "Please Upgrade your Package",
          ))
        : showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Gallery Image View',
                  style: Styles.bold_arsenic_14,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Remaining Gallery Picture View: ${state.accountState!.profileData!.remainingGalleryImageView} times",
                      textAlign: TextAlign.center,
                      style: Styles.regular_gull_grey_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "N.B. Requesting to See This Member Gallery Picture Will Cost 1 From Remaining Gallery Picture View.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      backgroundColor: MyTheme.zircon,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: Styles.buildLinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: MyTheme.white),
                      ),
                    ),
                    onPressed: () {
                      pleaseWaitDialog();
                      store.dispatch(sendGalleryPictureViewRequestAction(
                        id: widget.userId,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }

  Widget buildListView(BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal,
            left: Const.kPaddingHorizontal,
            bottom: 10),
        child: ListView(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyProfileListData(
              title2: "About",
              subtitle2:
                  "On Behalf ${state.publicProfileState!.basic?.onbehalf?.name}",
              icon2: 'assets/icon/icon_left_qoute.png',
              pp2: const PP_Information(),
            ).getExpandableWidget(context, index: 0),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Basic Information",
              icon2: 'assets/icon/icon_basicInfo.png',
              pp2: const PP_BasicInformation(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Contact Details",
              icon2: 'assets/icon/icon_contactDetails.png',
              pp2: PP_UserContactDetails(userid: widget.userId),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Present Address",
              icon2: 'assets/icon/icon_presentAddress.png',
              pp2: const PP_PresentAddress(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Education Details",
              icon2: 'assets/icon/icon_educationCareer.png',
              pp2: const PP_EducationInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Career Details",
              icon2: 'assets/icon/icon_educationCareer.png',
              pp2: const PP_CareerInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Physical Attributes",
              icon2: 'assets/icon/icon_physicalAttri.png',
              pp2: const PP_PhysicalAttributes(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Language",
              icon2: 'assets/icon/icon_language.png',
              pp2: const PP_Language(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Hobbies & Interest",
              icon2: 'assets/icon/icon_hobbiesInterest.png',
              pp2: const PP_HobbiesInterest(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Personal Attitude & Behavior",
              icon2: 'assets/icon/icon_personalAttitude.png',
              pp2: const PP_PersonalAttitude(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Residency Information",
              icon2: 'assets/icon/icon_residency.png',
              pp2: const PP_ResidencyInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Spiritual & Social Background",
              icon2: 'assets/icon/icon_spiritualSocial.png',
              pp2: const PP_SpiritualSocial(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Life Style",
              icon2: 'assets/icon/icon_lifeStyle.png',
              pp2: const PP_LifeStyle(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Astronomic Information",
              icon2: 'assets/icon/icon_astronomy.png',
              pp2: const PP_AstronomicInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Permanent Address",
              icon2: 'assets/icon/icon_permanentAddress.png',
              pp2: const PP_PermanentAddress(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Family Information",
              icon2: 'assets/icon/icon_family.png',
              pp2: const PP_FamilyInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  reportDialogBuilder() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.common_report_member,
            style: Styles.bold_arsenic_14,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.common_report_reason,
                style: Styles.regular_arsenic_14,
              ),
              TextField(
                maxLines: 5,
                controller: _reportController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: MyTheme.solitude,
                    border: InputBorder.none,
                    hintText:
                        AppLocalizations.of(context)!.common_report_reason),
              )
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppLocalizations.of(context)!.common_cancel,
                style: Styles.regular_arsenic_14,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppLocalizations.of(context)!.common_report,
                style: Styles.regular_arsenic_14,
              ),
              onPressed: () {
                store.dispatch(reportMiddleware(
                    userId: widget.userId, reason: _reportController.text));
                Navigator.of(context).pop();
                _reportController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildContainerGradient(mainContext, AppState state) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
        // border radius and stuff
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 22.0, left: 22.0, top: 10, bottom: 10),
          child: Column(
            children: [
              /// image name email and other more vertz field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/icon/icon_pop_white.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (state.publicProfileState != null &&
                          state.publicProfileState!.profilePicRequest)
                        showProfileLockIcon(state)
                      else
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: MyImages.normalImage(
                                state.publicProfileState!.basic?.photo),
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.publicProfileState!.basic?.firsName ?? '',
                            style: Styles.bold_white_14,
                          ),
                          Row(
                            children: [
                              Text(
                                "Member ID ",
                                style: Styles.regular_light_grey_12,
                              ),
                              Text(
                                state.publicProfileState!.basic?.code ?? '--',
                                style: Styles.regular_white_12,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  if (!isAuthUser)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 40,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => expressLove(state),
                        icon: SizedBox(
                          height: 18,
                          width: 18,
                          child: state.myInterestState!.isLoading!
                              ? const CircularProgressIndicator(
                                  color: MyTheme.white,
                                  strokeWidth: 1,
                                )
                              : Image.asset(
                                  'assets/icon/icon_love.png',
                                ),
                        ),
                      ),
                    )
                ],
              ),
              Const.height10,
              Const.whiteDivider,
              Const.height10,

              /// remaining boxes in are below
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.publicProfileState!.basic?.age ?? ''} yrs, ${state.publicProfileState!.physical?.height ?? ''} ft, ${state.publicProfileState!.basic?.maritialStatus ?? ''}",
                        style: Styles.regular_white_12,
                      ),
                      Text(
                        "${state.publicProfileState!.spiritual == null ? '' : state.publicProfileState!.spiritual.religionId + " " ?? ""} ${state.publicProfileState!.spiritual == null ? '' : state.publicProfileState!.spiritual.casteId ?? ""}",
                        style: Styles.regular_white_12,
                      ),
                    ],
                  ),
                  if (!isAuthUser &&
                      state.publicProfileState!.profilematch != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.public_profile,
                          style: Styles.regular_white_12,
                        ),
                        Text("${state.publicProfileState!.profilematch ?? 0} %",
                            style: Styles.bold_white_30)
                      ],
                    )
                ],
              ),
              Const.height20,

              TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  const Tab(
                    child: NavigationButton(
                      text: 'Full profile',
                    ),
                  ),
                  if (settingIsActive(
                      "member_partner_expectation_section", "on"))
                    const Tab(
                      child: NavigationButton(
                        text: 'Partner Preferences',
                      ),
                    ),
                  const Tab(
                    child: NavigationButton(
                      text: 'Gallery',
                    ),
                  ),
                ],
              ),
              Const.height18,
              if (!isAuthUser)
                Column(
                  children: [
                    Const.whiteDivider,
                    Const.height18,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        UserProfileActionButton(
                            onTap: () => reportDialogBuilder(),
                            text:
                                state.memberInfoState!.memberInfo!.reportStatus!
                                    ? AppLocalizations.of(context)!
                                        .my_profile_reported
                                    : AppLocalizations.of(context)!
                                        .my_profile_report,
                            icon: 'icon_report.png'),
                        UserProfileActionButton(
                            onTap: () => store.dispatch(
                                addShortlistMiddleware(userId: widget.userId)),
                            text: state.memberInfoState!.memberInfo!
                                        .shortlistStatus ==
                                    1
                                ? AppLocalizations.of(context)!
                                    .common_shortlisted
                                : AppLocalizations.of(context)!
                                    .common_shortlist,
                            icon: 'icon_shortlist_black.png'),
                        UserProfileActionButton(
                            onTap: () => store.dispatch(addIgnoreMiddleware(
                                userId: widget.userId, from: 'userprofile')),
                            text: AppLocalizations.of(context)!
                                .my_profile_ignore_user,
                            icon: 'icon_ignore_users.png'),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  pleaseWaitDialog() {
    return OneContext().showDialog<void>(
      builder: (BuildContext context) {
        store.state.publicProfileState!.loadingContext = context;
        store.state.publicProfileState!.galleryLoadingContext = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.circularIndicator,
              const Text(
                'Please Wait',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  galleryViewPermission(AppState state) {
    state.accountState!.profileData!.currentPackageInfo!.packageExpiry ==
                "Expired" ||
            state.accountState!.profileData!.remainingProfileImageView == 0
        ? store.dispatch(
            ShowMessageAction(
              msg: "Please Upgrade your Package",
            ),
          )
        : OneContext().showDialog<void>(
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Profile Picture View',
                  style: Styles.bold_arsenic_14,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Remaining Profile Picture View: ${state.accountState!.profileData!.remainingProfileImageView} times",
                      textAlign: TextAlign.center,
                      style: Styles.regular_gull_grey_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "N.B. Requesting to See This Member Profile Picture Will Cost 1 From Remaining Profile Picture View.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      backgroundColor: MyTheme.zircon,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: Styles.buildLinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: MyTheme.white),
                      ),
                    ),
                    onPressed: () {
                      pleaseWaitDialog();
                      store.dispatch(
                        sendProfilePictureViewRequestAction(
                          id: widget.userId,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }

  Widget showProfileLockIcon(AppState state) {
    return InkWell(
      onTap: () {
        if (!isAuthUser) {
          galleryViewPermission(state);
        }
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage:
                NetworkImage(state.publicProfileState!.basic?.photo),
          ),
          state.memberInfoState!.memberInfo!.profileViewRequestStatus!
              ? Container()
              : Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: MyTheme.light_grey,
                      ),
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/icon/icon_lock.png',
                        color: MyTheme.arsenic,
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

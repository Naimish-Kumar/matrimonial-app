import 'dart:core';
/*
class MyPublicProfile extends StatefulWidget {
  const MyPublicProfile({Key? key}) : super(key: key);

  @override
  State<MyPublicProfile> createState() => _MyPublicProfileState();
}

class _MyPublicProfileState extends State<MyPublicProfile> {
  var userId = store.state.authState?.userData?.id??"";
  var userName = store.state.authState?.userData?.name??"";
  var userEmail = store.state.authState?.userData?.email??"";
  var userAge =store.state.authState?.userData?.birthday??"";
  var userHeight = store.state.authState?.userData?.height??"";
  var userMaritalStatus =store.state.authState?.userData?.maritalStatusId?.name??"";


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.publicProfile),
        store.dispatch(publicProfileMiddleware(userId: userId)),
        // store.dispatch(galleryImageMiddleware()),
      ],
      builder: (_, state) => DefaultTabController(
        length:(settingIsActive("member_partner_expectation_section", "on"))? 3:2,
        child: Scaffold(
          key: _scaffoldKey,
          body: state.publicProfileState!.isFetching!
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                )
              : Column(
                  children: [
                    buildGradientLayout(context, state),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildListViewSeparated(state),
                          if(settingIsActive("member_partner_expectation_section", "on"))
                          PP_PartnerExpectation(),
                          buildGallery(state),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildGallery(AppState state) {
    return Container(
      child: state.publicProfileState!.photogallery!.isEmpty
          ? CommonWidget.noData
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10,
              ),
              child: MasonryGridView.count(
                padding: EdgeInsets.zero,
                itemCount: state.publicProfileState!.photogallery!.length,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemBuilder: (context, index) {
                  return GalleryViewCard(
                    imagePath:
                        state.publicProfileState!.photogallery![index].imagePath,
                  );
                },
              ),
            ),
    );
  }

  Widget buildListViewSeparated(AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal, left: Const.kPaddingHorizontal),
        child: ListView.separated(
          separatorBuilder: (context,index)=>const SizedBox(
            height: 5,
          ),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: getProfileViewModels.length,
          itemBuilder:(context,index)=>getProfileViewModels[index],
        ),
      ),
    );
  }

 List<Widget> get getProfileViewModels
    =>  [
      MyProfileListData(
        title2: "About",
        subtitle2: 'On Behalf: Selfs',
        icon2: 'assets/icon/icon_left_qoute.png',
        pp2: PP_Information(),
      ).getExpandableWidget(context, index: 0),
      const SizedBox(
        height: 20,
      ),
      MyProfileListData(
        title2: "Basic Information",
        icon2: 'assets/icon/icon_basicInfo.png',
        pp2: PP_BasicInformation(),
      ).getExpandableWidget(context),
      const SizedBox(
        height: 20,
      ),
      MyProfileListData(
        title2: "Contact Details",
        icon2: 'assets/icon/icon_contactDetails.png',
        pp2: PP_MyContactDetails(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_present_address_section", "on"))
      MyProfileListData(
        title2: "Present Address",
        icon2: 'assets/icon/icon_presentAddress.png',
        pp2: PP_PresentAddress(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_education_section", "on"))
      MyProfileListData(
        title2: "Education Details",
        icon2: 'assets/icon/icon_educationCareer.png',
        pp2: PP_EducationInfo(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_career_section", "on"))
      MyProfileListData(
        title2: "Career Details",
        icon2: 'assets/icon/icon_educationCareer.png',
        pp2: PP_CareerInfo(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_physical_attributes_section", "on"))
      MyProfileListData(
        title2: "Physical Attributes",
        icon2: 'assets/icon/icon_physicalAttri.png',
        pp2: PP_PhysicalAttributes(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_language_section", "on"))
      MyProfileListData(
        title2: "Language",
        icon2: 'assets/icon/icon_language.png',
        pp2: PP_Language(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_hobbies_and_interests_section", "on"))
      MyProfileListData(
        title2: "Hobbies And Interest",
        icon2: 'assets/icon/icon_hobbiesInterest.png',
        pp2: PP_HobbiesInterest(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_personal_attitude_and_behavior_section", "on"))
      MyProfileListData(
        title2: "Personal Attitude And Behavior",
        icon2: 'assets/icon/icon_personalAttitude.png',
        pp2: PP_PersonalAttitude(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_residency_information_section", "on"))
      MyProfileListData(
        title2: "Residency Information",
        icon2: 'assets/icon/icon_residency.png',
        pp2: PP_ResidencyInfo(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_spiritual_and_social_background_section", "on"))
      MyProfileListData(
        title2: "Spiritual And Social Background",
        icon2: 'assets/icon/icon_spiritualSocial.png',
        pp2: PP_SpiritualSocial(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_life_style_section", "on"))
      MyProfileListData(
        title2: "Life Style",
        icon2: 'assets/icon/icon_lifeStyle.png',
        pp2: PP_LifeStyle(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_astronomic_information_section", "on"))
      MyProfileListData(
        title2: "Astronomic Information",
        icon2: 'assets/icon/icon_astronomy.png',
        pp2: PP_AstronomicInfo(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_permanent_address_section", "on"))
      MyProfileListData(
        title2: "Permanent Address",
        icon2: 'assets/icon/icon_permanentAddress.png',
        pp2: PP_PermanentAddress(),
      ).getExpandableWidget(context),
      if(settingIsActive("member_family_information_section", "on"))
      MyProfileListData(
        title2: "Family Information",
        icon2: 'assets/icon/icon_family.png',
        pp2: PP_FamilyInfo(),
      ).getExpandableWidget(context),

    ];


  Widget buildGradientLayout(BuildContext context, AppState state) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          // linear gradient
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter),
          // border radius and stuff
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
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
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 25,
                        foregroundImage:
                            (state.accountState!.profileData!.memberPhoto == null
                                ? const AssetImage(
                                    'assets/images/default_avater.png')
                                : NetworkImage(
                                    state.accountState!.profileData!.memberPhoto!)) as ImageProvider<Object>?,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName!,
                            style: Styles.bold_white_14,
                          ),
                          Text(
                            userEmail!,
                            style: Styles.regular_white_12,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              /// horzontal line
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(.50),
              ),

              const SizedBox(
                height: 20,
              ),

              /// remaining boxes in are below
              Row(
                children: [
                  Text(
                    '$userAge years, $userHeight ft, $userMaritalStatus',
                    style: Styles.regular_white_10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
               TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  const Tab(
                    child: NavigationButton(
                      text: 'Full Profile',
                    ),
                  ),
                  if(settingIsActive("member_partner_expectation_section", "on"))
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
            ],
          ),
        ),
      ),
    );
  }
}
*/

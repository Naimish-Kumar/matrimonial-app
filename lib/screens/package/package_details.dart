import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_middlewares.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageDetails extends StatelessWidget {
  int? packageId;
  PackageDetails({Key? key, this.packageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.packageDetails),
        store.dispatch(packageDetailsMiddleware(packageId: packageId)),
      ],
      builder: (_, state) => Scaffold(
        appBar:
            CommonAppBar(text: AppLocalizations.of(context)!.package_details)
                .build(context),
        body: buildBody(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return state.packageDetailsState!.isFetching!
        ? CommonWidget.circularIndicator
        : Container(
            width: DeviceInfo(context).width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: [
                CommonWidget.box_shadow(),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // state.packageDetailsState.data.image == null
                  //     ?
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: MyImages.normalImage(
                        state.packageDetailsState!.data!.image!),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    state.packageDetailsState!.data!.name!,
                    style: Styles.regular_arsenic_14,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2713  ${state.packageDetailsState!.data!.expressInterest} ${AppLocalizations.of(context)!.premium_plans_express_interest}',
                        style: Styles.regular_arsenic_14,
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        '\u2713  ${state.packageDetailsState!.data!.photoGallery} ${AppLocalizations.of(context)!.premium_plans_gallery_photo_upload}',
                        style: Styles.regular_arsenic_14,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '\u2713  ${state.packageDetailsState!.data!.contact} ${AppLocalizations.of(context)!.premium_plans_contact_info_view}',
                        style: Styles.regular_arsenic_14,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      settingIsActive("profile_picture_privacy", "only_me")
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '\u2713  ${state.packageDetailsState!.data!.profileImageView} Profile Image View',
                                    style: Styles.regular_arsenic_14),
                                const SizedBox(
                                  height: 14.0,
                                ),
                              ],
                            )
                          : const Column(),
                      settingIsActive("gallery_image_privacy", "only_me")
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '\u2713  ${state.packageDetailsState!.data!.galleryImageView} Gallery Image View',
                                    style: Styles.regular_arsenic_14),
                                const SizedBox(
                                  height: 14.0,
                                ),
                              ],
                            )
                          : const Column(),
                      Text(
                        '\u2713  ${AppLocalizations.of(context)!.premium_plans_show_profile_match}',
                        style:
                            state.packageDetailsState!.data!.autoProfileMatch ==
                                    1
                                ? Styles.regular_arsenic_14
                                : Styles.regular_arsenic_14_line_through,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '\u2713  ${state.packageDetailsState!.data!.validity} ${AppLocalizations.of(context)!.premium_plans_days}',
                        style: Styles.regular_arsenic_14,
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      NavigatorPush.push(
                        context,
                        const PremiumPlans(),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MyTheme.app_accent_color)),
                    child: Text(
                      AppLocalizations.of(context)!.profile_screen_upgrade,
                      style: Styles.bold_white_14,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

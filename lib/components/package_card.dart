import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../const/my_theme.dart';
import '../const/style.dart';
import '../helpers/device_info.dart';
import '../helpers/navigator_push.dart';
import '../screens/core.dart';
import '../screens/payment_methods/payment.dart';
import 'common_widget.dart';
import 'custom_popup.dart';

class PackageCard extends StatelessWidget {
  final bool? isFetching;
  final List? packageList;
  final bool? profilePicturePrivacy;
  final bool? galleryPicturePrivacy;
  final bool? isLogin;

  const PackageCard({
    Key? key,
    this.isFetching,
    this.packageList,
    this.profilePicturePrivacy,
    this.galleryPicturePrivacy,
    this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _color = MyTheme.silver;
    var _solitude = MyTheme.solitude;
    var _arsenic = MyTheme.arsenic;
    double? packageCardHeight;
    if ((profilePicturePrivacy == true) && (galleryPicturePrivacy == true)) {
      packageCardHeight = 385.0;
    } else if ((profilePicturePrivacy == false) &&
        (galleryPicturePrivacy == false)) {
      packageCardHeight = 325.0;
    } else {
      packageCardHeight = 355.0;
    }

    return Container(
      height: packageCardHeight,
      width: DeviceInfo(context).width,
      child: isFetching!
          ? CommonWidget.circularIndicator
          : packageList!.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  scrollDirection: Axis.horizontal,
                  itemCount: packageList!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: packageList![index].price == 0
                                ? _solitude
                                : _arsenic,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                packageList![index].image == null
                                    ? const SizedBox(
                                        height: 40,
                                        width: 40,
                                      )
                                    : Image.network(
                                        packageList![index].image,
                                        height: 40,
                                        width: 40,
                                      ),
                                const SizedBox(
                                  height: 7.3,
                                ),
                                Text(
                                    packageList![index].price == 0
                                        ? packageList![index]
                                            .priceText
                                            .toString()
                                        : packageList![index]
                                            .priceText
                                            .toString(),
                                    style: packageList![index].price == 0
                                        ? Styles.bold_arsenic_12
                                        : Styles.bold_solitude_12),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(packageList![index].name,
                                    style: Styles.bold_storm_grey_12),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '\u2022 ${packageList![index].expressInterest} Express Interests',
                                        style: packageList![index].price == 0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${packageList![index].photoGallery} Gallery Photo Upload',
                                        style: packageList![index].price == 0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${packageList![index].contact} Contact Info View',
                                        style: packageList![index].price == 0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    profilePicturePrivacy!
                                        ? Column(
                                            children: [
                                              Text(
                                                  '\u2022 ${packageList![index].profileImageView} Profile Image View',
                                                  style: packageList![index]
                                                              .price ==
                                                          0
                                                      ? Styles
                                                          .regular_arsenic_12
                                                      : Styles
                                                          .regular_solitude_12),
                                              const SizedBox(
                                                height: 14.0,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    galleryPicturePrivacy!
                                        ? Column(
                                            children: [
                                              Text(
                                                  '\u2022 ${packageList![index].galleryImageView} Gallery Image View',
                                                  style: packageList![index]
                                                              .price ==
                                                          0
                                                      ? Styles
                                                          .regular_arsenic_12
                                                      : Styles
                                                          .regular_solitude_12),
                                              const SizedBox(
                                                height: 14.0,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Text('\u2022 Show Auto Profile Match',
                                        style: packageList![index].price == 0
                                            ? Styles.regular_arsenic_12
                                            : packageList![index]
                                                        .autoProfileMatch ==
                                                    1
                                                ? Styles.regular_solitude_12
                                                : packageList![index].price == 0
                                                    ? Styles
                                                        .regular_solitude_12_line_through
                                                    : Styles
                                                        .regular_white_12_line_through),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${packageList![index].validity} Days',
                                        style: packageList![index].price == 0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 20.2,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 100,
                                  decoration: packageList![index].packageId != 1
                                      ? BoxDecoration(
                                          gradient: Styles.buildLinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        )
                                      : BoxDecoration(
                                          color: _color,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                  child: InkWell(
                                    onTap: () {
                                      if (!store
                                          .state.userVerifyState!.isApprove!) {
                                        store.dispatch(
                                          ShowMessageAction(
                                            msg: "Please verify your account",
                                            color: MyTheme.failure,
                                          ),
                                        );
                                      } else {
                                        if (isLogin!) {
                                          packageList![index].packageId != 1
                                              ? NavigatorPush.push(
                                                  context,
                                                  Payment(
                                                    payment_type:
                                                        "package_payment",
                                                    title: "Package Payment",
                                                    amount: packageList![index]
                                                        .price
                                                        .toDouble(),
                                                    package_id:
                                                        packageList![index]
                                                            .packageId,
                                                  ),
                                                )
                                              : null;
                                        } else {
                                          CustomPopUp(context)
                                              .loginDialog(context);
                                        }
                                      }
                                    },
                                    child: Center(
                                      child: packageList![index].packageId == 1
                                          ? Text(
                                              AppLocalizations.of(context)!
                                                  .common_get_started,
                                              style: Styles
                                                  .medium_arsenic_12_line_through,
                                            )
                                          : Text(
                                              AppLocalizations.of(context)!
                                                  .common_purchase,
                                              style: Styles.medium_white_12,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : CommonWidget.noData,
    );
  }
}

import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_middlewares.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PremiumPlans extends StatefulWidget {
  const PremiumPlans({Key? key}) : super(key: key);

  @override
  State<PremiumPlans> createState() => _PremiumPlansState();
}

class _PremiumPlansState extends State<PremiumPlans> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PremiumPlansViewModel>(
      converter: (store) => PremiumPlansViewModel.fromStore(store),
      onInit: (store) {
        store.dispatch(Reset.packageList);
        store.dispatch(packageListMiddleware());
      },
      builder: (_, PremiumPlansViewModel vm) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)!.premium_plans_appbar_title)
            .build(context),
        body: vm.fetch!
            ? Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              )
            : Container(
                child: buildBody(context, vm),
              ),
      ),
    );
  }

  Widget buildBody(BuildContext context, PremiumPlansViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // choose your plan
        Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 17),
            child: buildChoosePlanBar(context)),
        const SizedBox(
          height: 40,
        ),

        // listview of the plan
        buildPackageLists(context, vm),
      ],
    );
  }

  Widget buildPackageLists(BuildContext context, PremiumPlansViewModel vm) {
    return Expanded(
      child: vm.list!.isEmpty
          ? Center(
              child: Text(AppLocalizations.of(context)!.common_no_data),
            )
          : buildListView(vm),
    );
  }

  Widget buildListView(PremiumPlansViewModel vm) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17.0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: vm.list!.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  boxShadow: [CommonWidget.box_shadow()]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                child: Column(
                  children: [
                    vm.list![index].image == null
                        ? SizedBox(
                            height: 40,
                            width: 40,
                          )
                        : Image.network(
                            vm.list![index].image,
                            height: 40,
                            width: 40,
                          ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      vm.list![index].name,
                      style: Styles.regular_arsenic_14,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${vm.list![index].priceText.toString()}',
                          style: TextStyle(
                              color: MyTheme.app_accent_color,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\u2713  ${vm.list![index].expressInterest} ${AppLocalizations.of(context)!.premium_plans_express_interest}',
                          style: Styles.regular_arsenic_14,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          '\u2713  ${vm.list![index].photoGallery} ${AppLocalizations.of(context)!.premium_plans_gallery_photo_upload}',
                          style: Styles.regular_arsenic_14,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '\u2713  ${vm.list![index].contact} ${AppLocalizations.of(context)!.premium_plans_contact_info_view}',
                          style: Styles.regular_arsenic_14,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Visibility(
                          visible: vm.galleryImagePrivacy,
                          child: Column(
                            children: [
                              Text(
                                '\u2713  ${vm.list![index].galleryImageView} Gallery Image View',
                                style: Styles.regular_arsenic_14,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: vm.pictureImagePrivacy,
                          child: Column(
                            children: [
                              Text(
                                '\u2713  ${vm.list![index].profileImageView} Profile Image View',
                                style: Styles.regular_arsenic_14,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\u2713 ${AppLocalizations.of(context)!.premium_plans_show_profile_match}',
                          style: vm.list![index].autoProfileMatch == 1
                              ? Styles.regular_arsenic_14
                              : Styles.regular_arsenic_14_line_through,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '\u2713  ${vm.list![index].validity} ${AppLocalizations.of(context)!.premium_plans_days}',
                          style: Styles.regular_arsenic_14,
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        if (!store.state.userVerifyState!.isApprove!) {
                          store.dispatch(
                            ShowMessageAction(
                              msg: "Please verify your account",
                              color: MyTheme.failure,
                            ),
                          );
                        } else {
                          vm.list![index].packageId != 1
                              ? NavigatorPush.push(
                                  context,
                                  Payment(
                                    title: "Package Payment",
                                    payment_type: "package_payment",
                                    amount: vm.list![index].price.toDouble(),
                                    package_id: vm.list![index].packageId,
                                  ),
                                )
                              : null;
                        }
                      },
                      style: vm.list![index].packageId == 1
                          ? ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(MyTheme.gull_grey))
                          : ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyTheme.app_accent_color)),
                      child: vm.list![index].packageId == 1
                          ? Text(
                              "Purchase",
                              style: Styles.bold_white_14_line_through,
                            )
                          : Text(
                              'Purchase',
                              style: Styles.bold_white_14,
                            ),
                    ),

                    // TextButton(onPressed: (){}, child: child)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildChoosePlanBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.premium_plans_choose_plan,
            style: Styles.bold_arsenic_16),
        const SizedBox(
          height: 5,
        ),
        Text(AppLocalizations.of(context)!.premium_plans_choose_plan_sub,
            style: Styles.regular_gull_grey_16),
      ],
    );
  }
}

class PremiumPlansViewModel {
  List<dynamic>? list = [];
  bool? fetch;
  var galleryImagePrivacy;
  var pictureImagePrivacy;
  String? currency_code;

  PremiumPlansViewModel({
    this.list,
    this.fetch,
    this.currency_code,
    this.galleryImagePrivacy,
    this.pictureImagePrivacy,
  });

  static fromStore(Store<AppState> store) {
    return PremiumPlansViewModel(
      list: store.state.premiumPlansState!.premiumList,
      fetch: store.state.premiumPlansState!.isFetching,
      galleryImagePrivacy: settingIsActive("gallery_image_privacy", "only_me"),
      pictureImagePrivacy:
          settingIsActive("profile_picture_privacy", "only_me"),
      currency_code: getSettingValue("system_default_currency"),
    );
  }
}

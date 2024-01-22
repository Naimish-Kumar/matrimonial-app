import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/middleware/profile_view_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowBasicSearch extends StatelessWidget {
  const ShowBasicSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
          text: AppLocalizations.of(context)!.show_search,
        ).build(context),
        body: state.basicSearchState!.isFetching!
            ? CommonWidget.circularIndicator
            : buildBody(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return SizedBox(
      height: DeviceInfo(context).height,
      child: state.basicSearchState!.searchList!.isNotEmpty
          ? ListView.separated(
              itemCount: state.basicSearchState!.searchList!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 14,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  child: GestureDetector(
                    onTap: () {
                      AIZRoute.push(
                          context,
                          UserPublicProfile(
                            userId: state
                                .basicSearchState!.searchList![index].userId,
                          ),
                          middleware: ProfileViewMiddleware(
                              context: context,
                              user: store.state.authState?.userData));
                    },
                    child: Container(
                      width: DeviceInfo(context).width,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: const Offset(0, 5.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 72,
                              width: 72,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: MyImages.normalImage(state
                                    .basicSearchState!
                                    .searchList![index]
                                    .photo),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.basicSearchState!.searchList![index]
                                          .firstName +
                                      ' ' +
                                      state.basicSearchState!.searchList![index]
                                          .lastName,
                                  style: Styles.medium_arsenic_14,
                                ),
                                Const.height5,
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .common_screen_member_id,
                                      style: Styles.regular_storm_grey_12,
                                    ),
                                    Text(
                                      state.basicSearchState!.searchList![index]
                                          .code,
                                      style: Styles.bold_storm_grey_12,
                                    )
                                  ],
                                ),
                                Const.height10,
                                Text(
                                    "${state.basicSearchState!.searchList![index].age} yrs ${state.basicSearchState!.searchList![index].height} feet ${state.basicSearchState!.searchList![index].maritalStatus}",
                                    style: Styles.regular_storm_grey_12),
                                Text(
                                    "${state.basicSearchState!.searchList![index].religion}, ${state.basicSearchState!.searchList![index].caste}",
                                    style: Styles.regular_storm_grey_12)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : CommonWidget.noData,
    );
  }
}

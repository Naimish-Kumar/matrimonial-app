import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Ignore extends StatefulWidget {
  const Ignore({Key? key}) : super(key: key);

  @override
  State<Ignore> createState() => _IgnoreState();
}

class _IgnoreState extends State<Ignore> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (!store.state.userVerifyState!.isApprove!) {
      OneContext().pop();
      store.dispatch(
        ShowMessageAction(
          msg: "Please verify your account",
          color: MyTheme.failure,
        ),
      );
    } else {
      store.dispatch(Reset.ignoreList);
      store.dispatch(ignoreMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.ignoreState!.hasMore) {
          store.dispatch(ignoreMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
                text:
                    AppLocalizations.of(context)!.ignore_screen_ignore_members)
            .build(context),
        body: Column(
          children: [
            state.ignoreState!.isFetching
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
                  )
                : buildListViewSeparated(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: state.ignoreState!.ignoreList!.isEmpty
          ? CommonWidget.noData
          : ListView.separated(
              controller: scrollController,
              itemCount: state.ignoreState!.ignoreList!.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  state.ignoreState!.ignoreList![index] == null
                      ? Const.heightShrink
                      : Const.height15,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.ignoreState!.ignoreList!.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: state.ignoreState!.hasMore
                          ? CircularProgressIndicator(
                              color: MyTheme.storm_grey,
                            )
                          : const Text('No more data'),
                    ),
                  );
                }
                if (state.ignoreState!.ignoreList![index] == null) {
                  return Const.heightShrink;
                }
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),

                  /// box decoration
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [CommonWidget.box_shadow()]),
                  // child0

                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: 135,
                            width: 84,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0)),
                              child: Image.network(
                                  state.ignoreState!.ignoreList![index].photo ??
                                      '',
                                  fit: BoxFit.cover
                                  // width: 84.0,
                                  ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              width: DeviceInfo(context).width,
                              decoration: const BoxDecoration(
                                  color: MyTheme.app_accent_color,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.0))),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    store.dispatch(IgnoreItemRemoveAction(
                                        data: state
                                            .ignoreState!.ignoreList![index]));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .ignore_screen_remove,
                                    style: Styles.bold_white_12,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, top: 16.0, right: 14.0, bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.ignoreState!.ignoreList![index].name,
                                style: Styles.bold_arsenic_14,
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${state.ignoreState!.ignoreList![index].age} years',
                                      style: Styles.regular_arsenic_14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.ignoreState!.ignoreList![index]
                                          .country,
                                      maxLines: 1,
                                      style: Styles.regular_arsenic_14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.ignoreState!.ignoreList![index]
                                          .religion,
                                      style: Styles.regular_arsenic_14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.ignoreState!.ignoreList![index]
                                          .mothereTongue,
                                      style: Styles.regular_arsenic_14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

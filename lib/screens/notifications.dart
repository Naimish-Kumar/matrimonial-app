import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_read_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/notificationListCard.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
      store.dispatch(Reset.notification);
      store.dispatch(notificationGetMiddleware());
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.notificationState!.hasMore!) {
          store.dispatch(notificationGetMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<String> items = ['Mark all as read'];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel vm) => Scaffold(
        appBar: buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: () {
            store.dispatch(Reset.notification);
            return store.dispatch(notificationGetMiddleware());
          },
          child: SafeArea(
            child: vm.isFetching == false
                ? buildListViewSeparated(vm)
                : CommonWidget.circularIndicator,
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeparated(_ViewModel vm) {
    return Container(
      child: vm.listofdata.isNotEmpty
          ? ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              itemCount: vm.listofdata.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 14,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == vm.listofdata.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: vm.hasMore
                          ? CircularProgressIndicator(
                              color: MyTheme.storm_grey,
                            )
                          : const Text('No more data'),
                    ),
                  );
                }

                return NotificationListCard(
                  type: vm.listofdata[index].type!,
                  photo: vm.listofdata[index].photo ?? '',
                  time: vm.listofdata[index].time!,
                  readAt: vm.listofdata[index].readAt!,
                  message: vm.listofdata[index].message!,
                  notifyBy: vm.listofdata[index].notifyBy!,
                );
              },
            )
          : CommonWidget.noData,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context)!.notifications_page_title,
        style: Styles.bold_app_accent_16,
      ),
      actions: [
        PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 20,
          ),
          onSelected: (dynamic value) {
            switch (value.toString().toLowerCase()) {
              case 'mark all as read':
                store.dispatch(notificationReadMiddleware());
                break;
            }
          },
          itemBuilder: (context) {
            return items
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList();
          },
        )
      ],
    );
  }
}

class _ViewModel {
  var listofdata;
  var error;
  var isFetching;
  var hasMore;

  _ViewModel({
    this.hasMore,
    this.listofdata,
    this.error,
    this.isFetching,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      listofdata: store.state.notificationState!.notification_list,
      error: store.state.notificationState!.error,
      isFetching: store.state.notificationState!.isFetching,
      hasMore: store.state.notificationState!.hasMore,
    );
  }
}

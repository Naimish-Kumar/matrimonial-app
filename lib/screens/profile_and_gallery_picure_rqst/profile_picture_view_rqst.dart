import 'package:active_matrimonial_flutter_app/components/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/profile_picture_view_card.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/device_info.dart';

class PictureProfileViewRqst extends StatefulWidget {
  const PictureProfileViewRqst({Key? key}) : super(key: key);

  @override
  State<PictureProfileViewRqst> createState() => _PictureProfileViewRqstState();
}

class _PictureProfileViewRqstState extends State<PictureProfileViewRqst> {
  ScrollController scrollController = ScrollController();
  final ScrollController _xcrollController = ScrollController();

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
      store.dispatch(PictureProfileReset());
      store.dispatch(getProfilePictureViewRequestMiddleware());
    }
    _xcrollController.addListener(() {
      if (_xcrollController.position.maxScrollExtent ==
          _xcrollController.offset) {
        var page = store.state.pictureProfileViewState!.page += 1;

        store.dispatch(getProfilePictureViewRequestMiddleware(page: page));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _xcrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      onWillChange: (_ViewModel? prev, _ViewModel current) {
        if (prev!.status == PictureProfileStatus.failure) {
          OneContext().showDialog(
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(current.error),
              );
            },
          );
        }
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel vm) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)!
                    .profile_picture_screen_appbar_title)
            .build(context),
        body: RefreshIndicator(
          onRefresh: () async {
            store.dispatch(PictureProfileReset());
            store.dispatch(getProfilePictureViewRequestMiddleware());
          },
          child: SingleChildScrollView(
              controller: _xcrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: body(context, vm)),
        ),
      ),
    );
  }

  Widget body(BuildContext maincontext, _ViewModel vm) {
    if (vm.showLoading) {
      return SizedBox(
        height: DeviceInfo(context).height,
        child: CommonWidget.circularIndicator,
      );
    }
    return SizedBox(
      height: DeviceInfo(context).height,
      child: vm.listofdata.isEmpty
          ? const Center(
              child: Text('No Request Found'),
            )
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: scrollController,
              itemCount: vm.listofdata.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  vm.listofdata[index] == null
                      ? Const.heightShrink
                      : Const.height15,
              itemBuilder: (BuildContext context, int index) {
                if (index == vm.listofdata.length && !vm.noMoreData) {
                  return SizedBox(
                    width: DeviceInfo(context).width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 1, width: 1),
                        CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ],
                    ),
                  );
                } else if (index == vm.listofdata.length && vm.noMoreData) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text('No more data'),
                    ),
                  );
                }
                if (vm.listofdata[index] == null) {
                  return Const.heightShrink;
                }
                return ProfilePictureViewCard(
                  index: index,
                  id: vm.listofdata[index].id,
                  name: vm.listofdata[index].name,
                  image: vm.listofdata[index].photo,
                  status: vm.listofdata[index].status,
                  age: vm.listofdata[index].dateOfBirth,
                );
              },
            ),
    );
  }
}

class _ViewModel {
  var listofdata;
  var status;
  var error;
  var showLoading;
  var noMoreData;

  _ViewModel({
    this.noMoreData,
    this.showLoading,
    this.listofdata,
    this.status,
    this.error,
  });

  @override
  String toString() {
    return '_ViewModel{listofdata: $listofdata, status: $status, error: $error, showLoading: $showLoading, noMoreData: $noMoreData}';
  }

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      listofdata: store.state.pictureProfileViewState!.pictureProfileList,
      status: store.state.pictureProfileViewState!.pictureProfileStatus,
      error: store.state.pictureProfileViewState!.error,
      showLoading: store.state.pictureProfileViewState!.showLoading,
      noMoreData: store.state.pictureProfileViewState!.noMoreData,
    );
  }
}

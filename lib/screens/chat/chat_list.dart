import 'dart:async';

import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/chat_list_widget.dart';
import '../../components/matched_profile_widget.dart';
import '../../const/my_theme.dart';
import '../../redux/libs/matched_profile/matched_profile_middleware.dart';

class ChatList extends StatefulWidget {
  bool? backButtonAppearance;

  ChatList({Key? key, this.backButtonAppearance}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  PageController matched_profile_controller = PageController();

  late Timer timer;

  @override
  void initState() {
    super.initState();

    if (!store.state.userVerifyState!.isApprove!) {
      if (widget.backButtonAppearance == true) {
        OneContext().pop();
      }
      store.dispatch(
        ShowMessageAction(
          msg: "Please verify your account",
          color: MyTheme.failure,
        ),
      );
    } else {
      store.dispatch(Reset.chatList);
      store.dispatch(chatMiddleware());
      store.dispatch(matchedProfileFetchAction());
      timer = Timer.periodic(const Duration(seconds: 20),
          (Timer t) => store.dispatch(chatMiddleware()));
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              store.dispatch(chatMiddleware());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchedProfileWidget(
                    matched_profile_controller: matched_profile_controller,
                    state: state),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.chat_list_messages,
                        style: Styles.bold_app_accent_16,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                /// messages container
                buildListViewMessagesContainer(context, state)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.backButtonAppearance!,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/icon/icon_pop.png',
                            height: 20,
                            width: 20,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.profile_screen_messages,
                  style: Styles.bold_app_accent_16,
                ),
              ],
            ),
            CommonWidget.social_button(
                onpressed: () {
                  NavigatorPush.push(context, const Notifications());
                },
                icon: "icon_bell.png",
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ],
        ),
      ),
    );
  }

  Widget buildListViewMessagesContainer(BuildContext context, AppState state) {
    return Expanded(
      child: state.chatState!.isFetching!
          ? CommonWidget.circularIndicator
          : state.chatState!.chatList!.isNotEmpty
              ? ListView.separated(
                  itemCount: state.chatState!.chatList!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      state.chatState!.chatList![index] == null
                          ? Const.heightShrink
                          : Const.height15,
                  itemBuilder: (BuildContext context, int index) {
                    if (state.chatState!.chatList![index] == null) {
                      return Const.heightShrink;
                    }

                    return ChatListWidget(
                      chatId: state.chatState!.chatList![index].id,
                      userId: state.chatState!.chatList![index].userId,
                      name: state.chatState!.chatList![index].memberName,
                      photo: state.chatState!.chatList![index].memberPhoto,
                      active: state.chatState!.chatList![index].active,
                      packageImage:
                          state.chatState!.chatList![index].memberPackage.image,
                      lastMessage:
                          state.chatState!.chatList![index].lastMessage,
                      unseenMessageCount:
                          state.chatState!.chatList![index].unseenMessageCount,
                    );
                  },
                )
              : CommonWidget.noData,
    );
  }
}

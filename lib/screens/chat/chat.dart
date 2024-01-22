import 'dart:async';

import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/middleware/profile_view_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_reply_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';

import '../../models_response/chat/chat_details_response.dart';
import '../../redux/libs/chat/chat_details_middleware.dart';

class Chat extends StatefulWidget {
  final int? chatId;
  final int userId;
  final dynamic name;
  final dynamic picture;

  Chat({this.chatId, required this.userId, Key? key, this.name, this.picture})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final my_text_controller = TextEditingController();
  // String? value;
  // var myId = prefs.getInt(Const.userId);
  var myId = store.state.authState!.userData!.id!;
  late Timer timer;

  fetchAll() {
    store.dispatch(Reset.chatDetailsList);
    store.dispatch(chatDetailsMiddleware(chatId: widget.chatId));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAll();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      store.dispatch(chatDetailsMiddleware(chatId: widget.chatId));
    });
  }

  @override
  void dispose() {
    my_text_controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context, state),
        body: state.chatDetailsState!.isFetching!
            ? Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal, vertical: 10.0),
                child: Stack(
                  children: [
                    state.chatDetailsState!.chatDetailsList == []
                        ? const Center(
                            child: Text('No Messages!'),
                          )
                        : ListView.separated(
                            reverse: true,
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: state.chatDetailsState!.chatDetailsList
                                    ?.messages?.length ??
                                0,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 20,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              /// storing data in chat details
                              ///  only for chat details
                              var chatDetails = state.chatDetailsState!
                                  .chatDetailsList?.messages?[index];
                              print("chatDetails?.attachment == null");
                              print(chatDetails?.attachment);

                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        chatDetails?.senderUserId == myId
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      if (chatDetails?.senderUserId != myId)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: MyImages.normalImage(
                                                widget.picture),
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        // width: 240,
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              DeviceInfo(context).width! / 1.5,
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        decoration:
                                            messageDecoration(chatDetails),
                                        // height: 50,

                                        child: chatDetails!.attachment!.isEmpty
                                            ? Text(
                                                chatDetails.message ?? '',
                                                style: TextStyle(
                                                    color: chatDetails
                                                                .senderUserId !=
                                                            myId
                                                        ? MyTheme.arsenic
                                                        : Colors.white),
                                                textAlign: TextAlign.start,
                                              )
                                            : showFiles(chatDetails),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      if (chatDetails.senderUserId == myId)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: MyImages.normalImage(state
                                                .chatDetailsState!
                                                .chatDetailsList!
                                                .authUserPhoto),
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    buildBottomMessageSection(context)
                  ],
                ),
              ),
      ),
    );
  }

  Wrap showFiles(Message? chatDetails) {
    return Wrap(
      spacing: 4,
      runSpacing: 10,
      children: List.generate(
        chatDetails?.attachment?.length ?? 0,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: showAttachment(
              chatDetails!.attachment!.length, chatDetails.attachment![index]),
        ),
      ),
    );
  }

  BoxDecoration messageDecoration(chatDetails) {
    return BoxDecoration(
      color: chatDetails.senderUserId != myId
          ? MyTheme.solitude
          : MyTheme.app_accent_color,
      borderRadius: chatDetails.senderUserId == myId
          ? const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(6.0))
          : const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(12.0)),
    );
  }

  Widget buildBottomMessageSection(BuildContext context) {
    return Positioned(
        bottom: 5,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: DeviceInfo(context).width! - 100,
              decoration: BoxDecoration(
                  color: MyTheme.zircon,
                  borderRadius: const BorderRadius.all(Radius.circular(35.0))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: my_text_controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your message here...',
                    hintStyle: TextStyle(
                      color: MyTheme.storm_grey,
                    ),
                  ),
                ),
              ),
            ),

            /// send button
            InkWell(
              onTap: () {
                store.dispatch(chatReplyMiddleware(
                    id: widget.chatId,
                    text: my_text_controller.text,
                    attachment: null));
                my_text_controller.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: CircleAvatar(
                backgroundColor: MyTheme.app_accent_color,
                child: Center(
                  child: Image.asset(
                    'assets/icon/icon_send.png',
                    height: 25,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildAppBarContainer(
    BuildContext context,
    AppState state,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: Const.kPaddingHorizontal, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              AIZRoute.push(
                  context,
                  UserPublicProfile(
                    userId: widget.userId,
                  ),
                  middleware: ProfileViewMiddleware(
                      context: context, user: store.state.authState?.userData));
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: MyImages.normalImage(widget.picture),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.name, style: Styles.bold_arsenic_16),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, AppState state) {
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
      title: buildAppBarContainer(context, state),
    );
  }

  Widget showAttachment(int length, Attachment chatDetails) {
    if (chatDetails.attachmentType == "image") {
      return SizedBox(
          width: 80,
          height: 80,
          child: MyImages.normalImage(chatDetails.attachment));
    }

    return Container(
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.grey[400]),
      width: 80,
      height: 80,
      child: Wrap(
        children: [
          Text(chatDetails.fileName ?? '',
              style: const TextStyle(
                color: MyTheme.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          Text(
            ".${chatDetails.extension ?? ''}",
            style: const TextStyle(color: MyTheme.white),
          ),
        ],
      ),
    );
  }
}

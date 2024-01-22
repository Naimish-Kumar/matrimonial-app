import 'package:flutter/material.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../const/style.dart';
import '../screens/chat/chat.dart';
import 'common_widget.dart';
import 'my_images.dart';

class ChatListWidget extends StatelessWidget {
  final int chatId;
  final int userId;
  final String name;
  final String photo;
  final String packageImage;
  final int active;
  final String? lastMessage;
  final int unseenMessageCount;
  const ChatListWidget({
    Key? key,
    required this.chatId,
    required this.userId,
    required this.name,
    required this.photo,
    required this.active,
    required this.packageImage,
    required this.lastMessage,
    required this.unseenMessageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chat(
              chatId: chatId,
              userId: userId,
              name: name,
              picture: photo,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Const.kPaddingHorizontal,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: MyTheme.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 14.0,
              top: Const.kPaddingVertical,
              bottom: Const.kPaddingVertical,
              right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: MyImages.normalImage(photo),
                        ),
                      ),
                      Positioned(
                        right: 6,
                        left: 25,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active == 0
                                  ? Colors.red[400]
                                  : Colors.green[400]),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// name and message
                      Row(
                        children: [
                          Text(
                            name,
                            style: Styles.bold_arsenic_16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 24,
                            child: Image.network(packageImage),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(lastMessage ?? "",
                            maxLines: 1,
                            style: Styles.regular_gull_grey_12,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
              unseenMessageCount == 0
                  ? const Text('')
                  : Container(
                      height: 20,
                      width: 22,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          color: MyTheme.zircon),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        child: Text(
                          unseenMessageCount.toString(),
                          style:
                              const TextStyle(color: MyTheme.app_accent_color),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

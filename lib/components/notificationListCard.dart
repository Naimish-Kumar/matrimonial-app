import 'package:flutter/material.dart';

import '../const/const.dart';
import '../const/my_theme.dart';
import '../helpers/device_info.dart';
import '../helpers/navigator_push.dart';
import '../screens/main.dart';
import '../screens/my_dashboard_pages/interest_requests.dart';
import '../screens/my_dashboard_pages/my_interest.dart';
import '../screens/profile_and_gallery_picure_rqst/gallery_picture_view_rqst.dart';
import '../screens/profile_and_gallery_picure_rqst/profile_picture_view_rqst.dart';
import '../screens/user_pages/user_public_profile.dart';
import 'common_widget.dart';
import 'my_images.dart';

class NotificationListCard extends StatelessWidget {
  final String? type;
  final String? photo;
  final String? time;
  final String? readAt;
  final String? message;
  final int? notifyBy;

  const NotificationListCard({
    Key? key,
    this.type,
    this.photo,
    this.time,
    this.readAt,
    this.message,
    this.notifyBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (type) {
          case 'express_interest':
            NavigatorPush.push(context, const InterestRequest());
            break;
          case 'accept_interest':
            NavigatorPush.push(context, const MyInterest());
            break;
          case 'profile_picture_view':
            NavigatorPush.push(context, const PictureProfileViewRqst());
            break;
          case 'gallery_image_view':
            NavigatorPush.push(context, const GalleryProfileViewRqst());
            break;
          case 'reject_profile_image_view_request':
            NavigatorPush.push(context, const Main());
            break;
          case 'accept_profile_picture_view_request':
          case 'accept_gallery_image_view_request':
          case 'reject_gallery_image_view_request':
            NavigatorPush.push(context, UserPublicProfile(userId: notifyBy!));
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: DeviceInfo(context).width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: [CommonWidget.box_shadow()]),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 14, bottom: 14, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: MyImages.normalImage(photo),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: DeviceInfo(context).width! * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(time!),
                        readAt != "read"
                            ? Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                    color: MyTheme.failure,
                                    shape: BoxShape.circle),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Const.height15,
                  SizedBox(
                    width: DeviceInfo(context).width! * 0.66,
                    child: Text(
                      message!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

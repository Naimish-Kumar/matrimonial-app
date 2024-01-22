import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_context/one_context.dart';
import '../repository/app_info_repository.dart';
import '../screens/auth/signin.dart';
import '../screens/main.dart';
import '../screens/my_dashboard_pages/interest_requests.dart';
import '../screens/my_dashboard_pages/my_interest.dart';
import '../screens/profile_and_gallery_picure_rqst/gallery_picture_view_rqst.dart';
import '../screens/profile_and_gallery_picure_rqst/profile_picture_view_rqst.dart';
import '../screens/user_pages/user_public_profile.dart';
import 'navigator_push.dart';

final FirebaseMessaging _fcm = FirebaseMessaging.instance;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  '0', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotificationService {
  Future<void> initNotifications() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final fCMToken = await _fcm.getToken();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (fCMToken != null) {
      if (isLogedin) {
        // update device token
        var deviceTokenUpdateResponse = await AppInfoRepository()
            .getDeviceTokenUpdateResponse(deviceToken: fCMToken);
      }
    }

    FirebaseMessaging.onMessage.listen((event) async {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      var initializationSettingsAndroid = AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher

      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings();

      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      @pragma('vm:entry-point')
      void onDidReceiveNotificationResponse(
          NotificationResponse notificationResponse) async {
        await _handleMessage(event);
      }

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
      );

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // icon: android?.smallIcon,
              // other properties...
            ),
          ),
        );
      }
    });

    // background

    // on message open app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _handleMessage(message);
    });
  }
}

_handleMessage(RemoteMessage message) {
  print("in handle message");
  if (isLogedin == false) {
    OneContext().showDialog(
        // barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("You are not logged in"),
              content: const Text("Please log in"),
              actions: [
                TextButton(
                    child: const Text('close'),
                    onPressed: () => OneContext().popDialog()),
                TextButton(
                    child: const Text('Login'),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      OneContext().popDialog();
                      OneContext().push(MaterialPageRoute(builder: (_) {
                        return Login();
                      }));
                    }),
              ],
            ));
    return;
  }
  switch (message.data['route']) {
    case 'express_interest':
      NavigatorPush.push(OneContext().context, const InterestRequest());
      break;
    case 'accept_interest':
      NavigatorPush.push(OneContext().context, const MyInterest());
      break;
    case 'profile_picture_view':
      NavigatorPush.push(OneContext().context, const PictureProfileViewRqst());
      break;
    case 'gallery_image_view':
      NavigatorPush.push(OneContext().context, const GalleryProfileViewRqst());
      break;
    case 'reject_profile_image_view_request':
      NavigatorPush.push(OneContext().context, const Main());
      break;
    case 'accept_profile_picture_view_request':
    case 'accept_gallery_image_view_request':
    case 'reject_gallery_image_view_request':
      NavigatorPush.push(OneContext().context,
          UserPublicProfile(userId: message.data['notify_by']!));

      break;
  }
}

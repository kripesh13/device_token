// import 'dart:math';

// import 'package:app_settings/app_settings.dart';
// import 'package:device_token/offer/offer_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> requestNotificationPermissions() async {
//     try {
//       NotificationSettings settings = await firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: true,
//         criticalAlert: true,
//         provisional: true,
//         sound: true,
//       );

//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         debugPrint('User granted permission');
//       } else if (settings.authorizationStatus ==
//           AuthorizationStatus.provisional) {
//         debugPrint('User granted provisional permission');
//       } else {
//         debugPrint('User declined or has not accepted permission');
//         AppSettings.openAppSettings();
//       }
//     } catch (e) {
//       debugPrint('Error requesting notification permissions: $e');
//     }
//   }

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void intiLocalNotification(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_luncher');
//     var iosInitializationSettings = DarwinInitializationSettings();
//     // var androidInitializationSettings =
//     //     AndroidInitializationSettings('@drawable/ic_luncher');
//     var initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onDidReceiveBackgroundNotificationResponse:
//       onDidReceiveNotificationResponse: (payload) {
//         handelMessage(context, message);
//       },
//     );
//   }

//   firebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       print(message.notification!.title.toString());
//       print(message.notification!.body.toString());
//       print(message.data);
//       intiLocalNotification(context, message);
//       showNotification(message);
//     });
//   }

//   void showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
//       Random.secure().nextInt(10000).toString(),
//       'Very impotant message',
//       importance: Importance.max,
//     );

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             androidChannel.id.toString(), androidChannel.name.toString(),
//             channelDescription: 'Our Channel Description',
//             importance: Importance.high,
//             priority: Priority.high,
//             ticker: 'ticker');

//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//     Future.delayed(Duration.zero, () {
//       flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }

//   Future<String?> getToken() async {
//     String? token = await firebaseMessaging.getToken();
//     return token;
//   }

//   void refreshToken() async {
//     firebaseMessaging.onTokenRefresh.listen((event) {
//       event.toString();
//     });
//   }

//   handelMessage(BuildContext context, RemoteMessage message) {
//     if (message.data['type'] == 'offer') {
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return  OfferScrren();
//         },
//       ));
//     }
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:device_token/offer/offer_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermissions() async {
    try {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
        AppSettings.openAppSettings();
      }
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification!.title.toString());
      debugPrint(message.notification!.body.toString());
      debugPrint(message.data.toString());
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  void showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'Very important message',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          // Have to provide real data when aviable
      androidChannel.id.toString(),
      androidChannel.name.toString(),
      channelDescription: 'Our Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    return token;
  }

  void refreshToken() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      debugPrint('New token: $event');
    });
  }

  Future<void> setUpInteractiontMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'offer') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OfferScreen(),
          ));
    }
  }
}

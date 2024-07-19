import 'package:device_token/fireImage/fire_image_screen.dart';
import 'package:device_token/fireImage/fire_image_state.dart';
import 'package:device_token/fireStore/fire_store_state.dart';
import 'package:device_token/fireStore/firestore_screen.dart';
import 'package:device_token/firebase_options.dart';
import 'package:device_token/home/home_screen.dart';
import 'package:device_token/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Instantiate and request notification permissions
  NotificationServices notificationServices = NotificationServices();
  await notificationServices.requestNotificationPermissions();

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // Add error handling
  try {
    if (message.notification != null) {
      print(message.notification!.body);
    }
  } catch (e) {
    print('Error handling background message: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: ChangeNotifierProvider(
      //   child: const FireStoreScreen(),
      //   create: (context) => FireStoreState(),
      // ),
      home: ChangeNotifierProvider(
        child: const FireImageScreen(),
        create: (context) => FireImageState(),
      ),
    );
  }
}

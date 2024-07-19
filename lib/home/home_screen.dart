import 'package:device_token/services/service_token.dart';
import 'package:flutter/material.dart';
import 'package:device_token/services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  String? token;
  ServiceToken serviceToken = ServiceToken();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermissions();
    // notificationServices.refreshToken();
    notificationServices.firebaseInit(context);
    notificationServices.setUpInteractiontMessage(context);
    notificationServices.getToken().then((value) {
      setState(() {
        token = value;
      });
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: InkWell(
        onTap: () async {
          await serviceToken.getToken();
        },
        child: Center(
          child: Text(token ?? "Token not available"),
        ),
      ),
    );
  }
}

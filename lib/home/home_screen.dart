import 'package:device_token/realTimeDatabase/realTime_database_state.dart';
import 'package:device_token/realTimeDatabase/realtime_database.dart';
import 'package:device_token/services/service_token.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:device_token/services/notification_services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
        body: Center(
          child: InkWell(
            child: Text("Real time data base"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      child: const RealTimeDatabseScreen(),
                      create: (_) => RealTimeDataBase(),
                    ),
                  ));
            },
          ),
        ));
  }
}

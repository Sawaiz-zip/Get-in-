import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_in/Google_maps.dart';
import 'package:get_in/HomeScreen.dart';
import 'package:get_in/EnterMobileNumber.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EnterMobileNumber.dart';
import 'package:get_in/Otp_Verification.dart';
import 'package:get_in/StartScreen.dart';
import 'package:get_in/models/Driver.dart';
import 'package:get_in/models/DriverVerifyResponse.dart';
import 'package:get_in/models/DriverVerifyResponse_data.dart';
import 'package:get_in/Shared_memory/Shared_Preference.dart';
import 'package:get_in/EnterMobileNumber.dart';
import 'package:get_in/ChangeNotifier/Change_Notifier.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High_Importance Notification',
  'Channel for imp notifications',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
DriverVerifyResponse_data collect_responce3;
List<String> message_Title = [];
List<String> message_Body = [];
Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.data != null) {
    message_Title.add(message.notification.title);
    message_Body.add(message.notification.body);

    print(message.data.toString());
    print(message.notification.title);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  collect_responce3 = await get_driver_data();

//  collect_responce3.data.accessToken = null;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
//opens app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        setState(() {
          message_Title.add(message.notification.title);
          message_Body.add(message.notification.body);
        });
        final routeFromMessage = message.data["Google_Maps"];
        Navigator.of(context).push(routeFromMessage);
      }
    });
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        print('message notification title${message.notification.title}');
        print('message notification body${message.notification.body}');
        setState(() {
          message_Title.add(message.notification.title);
          message_Body.add(message.notification.body);
        });

        print('message notification title$message_Title');
        print('message notification body$message_Body');
      }
    });
    //opened state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      setState(() {
        message_Title.add(message.notification.title);
        message_Body.add(message.notification.body);
      });
      final routeFromMessage = message.data["Google_Maps"];
      Navigator.of(context).push(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Change_Notifier(),
        child: MaterialApp(
          home: collect_responce3 == null ? HomeScreen() : StartScreen(),
          routes: {
            'HomeScreen': (context) => HomeScreen(),
            'EnterMobileNumber': (context) => EnterMobileNumber(),
            'Otp_Verification': (context) => Otp_Verification(),
            'StartScreen': (context) => StartScreen(),
            'Google_Maps': (context) => Google_Maps(),
          },
        ));
  }
}

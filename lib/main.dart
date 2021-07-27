
import 'package:flutter/material.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DriverVerifyResponse_data collect_responce3 = await get_driver_data();

  print(collect_responce3);
 collect_responce3.data.accessToken = null;
  runApp(ChangeNotifierProvider(
    create: (context)=> Change_Notifier(),
    child: MaterialApp(
      home: collect_responce3.data.accessToken == null
          ? HomeScreen()
          : StartScreen(),
      routes: {
        'HomeScreen': (context) => HomeScreen(),
        'EnterMobileNumber': (context) => EnterMobileNumber(),
        'Otp_Verification': (context) => Otp_Verification(),
        'StartScreen': (context) => StartScreen(),
        'Google_Maps': (context)=>Google_Maps(),
      },
    )
    ),
   );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_in/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_in/models/Driver.dart';
import 'package:get_in/models/DriverVerifyResponse.dart';
import 'package:get_in/models/DriverVerifyResponse_data.dart';


  Future<void> saveUserInfo() async {
    final DriverVerifyResponse_data Set_driver_verify = collect_response1;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(
        'driver', jsonEncode(Set_driver_verify));
    print('this is shared preference$result');
    print('this is shared preference${Set_driver_verify.message}');
  }
  Future<void>setNotifications()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
     List<String> notification_title=message_Title;
     bool result=await prefs.setStringList('notification_title', notification_title);
    List<String> notification_body=message_Body;
    bool result1=await prefs.setStringList('notification_body', notification_title);
    print('this is shared preference for notification$result');
    print('this is shared preference$notification_title');
    print('this is shared preference for notification$result1');
    print('this is shared preference$notification_body');
  }
  Future<void>getNotifications_title()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
     List<String> notification_title=pref.getStringList('notification_title');
     if(notification_title!=null)
       {
         print('getting notification_title: $notification_title');
         return notification_title;
       }

  }
Future<void>getNotifications_body()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  List<String> notification_body=pref.getStringList('notification_body');
  if(notification_body!=null)
  {
    print('getting notification_body: $notification_body');
    return notification_body;
  }

}

  Future<DriverVerifyResponse_data> get_driver_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> driver_map;
    final String driverstr = preferences.getString('driver');
    if (driverstr != null) {
      driver_map = jsonDecode(driverstr) as Map<String, dynamic>;
    }
    if (driverstr != null) {
      final DriverVerifyResponse_data Get_driver_verify =
      DriverVerifyResponse_data.fromJson(jsonDecode(driverstr));
      print(Get_driver_verify);
      return Get_driver_verify;
    }
    return null;
  }

import 'dart:convert';

import 'package:flutter/material.dart';
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

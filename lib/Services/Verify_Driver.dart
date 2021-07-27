import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/DriverVerifyResponse.dart';
import '../models/DriverVerifyResponse_data.dart';
import 'Api_Request.dart';

  Future<DriverVerifyResponse_data> Verify_driver(
      String phone_no, String password) async {

    Object body;
    body={
      'password':password,
      'phone_no':phone_no
    };

    final response = await apiRequest('/api/driver/login', 'post', body);

// ignore: unrelated_type_equality_checks
    print(response.body);
    DriverVerifyResponse driverstatus;
    // print(response.body);

    driverstatus = DriverVerifyResponse.fromJson(jsonDecode(response.body));
    try {
      if (response.statusCode == 200 && driverstatus.success == true) {
        print('hello');
        print(response.body);

        return DriverVerifyResponse_data.fromJson(jsonDecode(response.body));
      } else {
        print(driverstatus.message);
        //throw Exception('Failed to create album.');
        return null;
      }
    } catch (e) {
      print(e);
    }
  }


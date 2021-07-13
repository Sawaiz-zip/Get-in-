
import 'package:flutter/material.dart';
import 'package:get_in/models/DriverVerifyResponse.dart';
import 'package:get_in/models/DriverVerifyResponse_data.dart';
class Otp_Verification_Function
{

  bool Otp_verification(String pin)
  {
    print('pin:$pin');
    int pin1 = int.parse(pin);
    print('vcode:${collect_response1.data.driver.vcode}');
    int vcode = collect_response1.data.driver.vcode;
    print(vcode);
    if(vcode==pin) {
      return true;
    }


  }
}
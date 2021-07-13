import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_in/Shared_memory/Shared_Preference.dart';
import 'package:http/http.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get_in/Otp_Verification.dart';
import 'package:http/http.dart' as http;
import 'package:get_in/models/Driver.dart';
import 'package:get_in/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_in/models/data.dart';
import 'package:get_in/models/DriverVerifyResponse.dart';
import 'package:get_in/models/DriverVerifyResponse_data.dart';
import 'package:get_in/models/Driver_model.dart';
import 'package:get_in/models/Api_Request.dart';
import 'package:get_in/models/Verify_Driver.dart';

class EnterMobileNumber extends StatefulWidget {
  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  void Otp_Verification_func() {
    String phoneNumber = "3341299921"; //enter your 10 digit number
    int minNumber = 1000;
    int maxNumber = 6000;
    String countryCode =
        "+92"; // give your country code if not it will take +1 as default
    otp.sendOtp(
        phoneNumber, 'OTP is : 123 ', minNumber, maxNumber, countryCode);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  String num, phone_no, country_Code;
  bool input_validate;
  // Shared_Preference sharedPreferences=new Shared_Preference();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: _size.height,
            width: _size.width,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Center(
                        child: Text(
                          'Enter Mobile Number',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                setState(() {
                                  num = number.phoneNumber;
                                });

                                print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                input_validate = value;
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 135.0, right: 30),
                                    child: TextFormField(
                                      controller: password,
                                      decoration: InputDecoration(
                                        labelText: "password",
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: TextFormField(
                                  //     controller: email,
                                  //     decoration: InputDecoration(
                                  //       labelText: "email",
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 150,
                                  ),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 50),
                                      margin:
                                          EdgeInsets.only(left: 36, right: 36),
                                      child: RaisedButton(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100,
                                                right: 100,
                                                top: 15,
                                                bottom: 15),
                                            child: Text(
                                              'Continue',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          color: Colors.red.shade700,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          onPressed: () async {
                                            formKey.currentState.validate();
                                            if (input_validate == true) {
                                              phone_no =
                                                  "0" + num.substring(3, 13);
                                              country_Code =
                                                  num.substring(0, 3);
                                              print(password.text);
                                              print(
                                                  'country code is ===>>$country_Code');
                                              print('mob num===>>>$phone_no');
                                              print(num);
                                              final DriverVerifyResponse_data
                                                  collect_response =
                                                  await Verify_driver(
                                                      phone_no, password.text);

                                              if (collect_response == null) {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          title: const Text(
                                                              'Error'),
                                                          content: Text(
                                                              'Incorrect Credentials'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                })
                                                          ]);
                                                    });
                                              } else {
                                                setState(() {
                                                  collect_response1 =
                                                      collect_response;
                                                });
                                                saveUserInfo()
                                                    .whenComplete(() async {
                                                  DriverVerifyResponse_data
                                                      collect_response2 =
                                                      await get_driver_data();
                                                  print(
                                                      'getting data from shared memory ${collect_response2.message}');
                                                });

                                                Otp_Verification_func();
                                                Navigator.pushNamed(context,
                                                    'Otp_Verification');
                                              }
                                            } else {
                                              print('Error');
                                            }
                                          }

                                          //getPhoneNumber('+15417543010');

                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_in/EnterMobileNumber.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:get_in/models/Driver.dart';
import 'package:get_in/models/DriverVerifyResponse.dart';
import 'package:get_in/models/DriverVerifyResponse_data.dart';
import 'package:get_in/Services/Otp_Verification_Function.dart';
FlutterOtp otp = FlutterOtp();

class Otp_Verification extends StatefulWidget {
  @override
  _Otp_VerificationState createState() => _Otp_VerificationState();
}

class _Otp_VerificationState extends State<Otp_Verification> {
  String phoneNumber = "3145175863";
  int minNumber = 1000;

  int maxNumber = 6000;

  String countryCode = "+92";

  String pin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // appBar: AppBar(title: Text("send otp using flutter_otp ")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.white,
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Center(
                      child: Text(
                        'Verify Code',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            'A code has been sent to your number',
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(80),
              child: PinEntryTextField(
                  showFieldAsBox: true,
                  onSubmit: (value) {
                    this.pin = value;
                    // showDialog(context: context, builder: (context){
                    //   return AlertDialog(
                    //     title: Text("pin"),
                    //     content: Text('pin entered is $pin'),
                    // );
                    // }
                    //);

                    print(pin);
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 0),
            // margin: EdgeInsets.only(left: 36, right: 36),
            child: RaisedButton(
                padding: EdgeInsets.all(10),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Press Here to Resend Code',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.red.shade700,
                onPressed: () {
                  // Navigator.pushNamed(context, 'Otp_Verification');
                }

                //getPhoneNumber('+15417543010');
                ),
          ),
          Container(
            padding: EdgeInsets.only(top: 60),
            margin: EdgeInsets.only(left: 36, right: 36),
            child: RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, top: 15, bottom: 15),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                color: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  print('pin:$pin');
                  int pin1 = int.parse(pin);
                  print('vcode:${collect_response1.data.driver.vcode}');
                  int vcode = collect_response1.data.driver.vcode;
                  print(vcode);
                  if(vcode==pin1) {
                    print('hello');
                    Navigator.pushNamed(context, 'StartScreen');
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Invalid Code'),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ]);
                        });
                  }
                }

                //getPhoneNumber('+15417543010');
                ),
          ),
        ],
      ),
    );
  }
}



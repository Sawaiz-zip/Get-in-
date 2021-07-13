import 'package:flutter/material.dart';
class Driver_model
{
  String password;
  String phoneNo;
  Driver_model({this.password,this.phoneNo});
  factory Driver_model.fromJson(Map<String, dynamic> json) => Driver_model(
    password: json["password"],
    phoneNo: json["phone_no"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "phone_no": phoneNo,
  };

}
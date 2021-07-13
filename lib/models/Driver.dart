import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_in/models/data.dart';
import 'package:get_in/EnterMobileNumber.dart';
class Driver {
  Driver({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.countrycode,
    this.countryId,
    this.cityId,
    this.socialAccount,
    this.socialAccountId,
    this.dob,
    this.gender,
    this.status,
    this.photo,
    this.cnic,
    this.ratings,
    this.earnings,
    this.licenseNo,
    this.licenseExpiry,
    this.vcode,
    this.vcodeExpiry,
    this.isOnline,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  String password;
  String phoneNo;
  String countrycode;
  int countryId;
  int cityId;
  DateTime socialAccount;
  dynamic socialAccountId;
  dynamic dob;
  int gender;
  int status;
  dynamic photo;
  String cnic;
  String ratings;
  String earnings;
  dynamic licenseNo;
  dynamic licenseExpiry;
  int vcode;
  DateTime vcodeExpiry;
  dynamic isOnline;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;


  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phone_no"],
        countrycode: json["countrycode"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        socialAccount: DateTime.parse(json["social_account"]),
        socialAccountId: json["social_account_id"],
        dob: json["dob"],
        gender: json["gender"],
        status: json["status"],
        photo: json["photo"],
        cnic: json["cnic"],
        ratings: json["ratings"],
        earnings: json["earnings"],
        licenseNo: json["license_no"],
        licenseExpiry: json["license_expiry"],
        vcode: json["vcode"],
        vcodeExpiry: DateTime.parse(json["vcode_expiry"]),
        isOnline: json["is_online"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "countrycode": countrycode,
        "country_id": countryId,
        "city_id": cityId,
        "social_account":
            "${socialAccount.year.toString().padLeft(4, '0')}-${socialAccount.month.toString().padLeft(2, '0')}-${socialAccount.day.toString().padLeft(2, '0')}",
        "social_account_id": socialAccountId,
        "dob": dob,
        "gender": gender,
        "status": status,
        "photo": photo,
        "cnic": cnic,
        "ratings": ratings,
        "earnings": earnings,
        "license_no": licenseNo,
        "license_expiry": licenseExpiry,
        "vcode": vcode,
        "vcode_expiry": vcodeExpiry.toIso8601String(),
        "is_online": isOnline,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  void set_password(String value) {
   password= value;
  }
  String get_password()
  {
    return password;
  }

} Driver d1;


import 'Driver.dart';

class Data {
  Data({
    this.driver,
    this.accessToken,
  });

  Driver driver;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    driver: Driver.fromJson(json["driver"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "driver": driver.toJson(),
    "access_token": accessToken,
  };
}
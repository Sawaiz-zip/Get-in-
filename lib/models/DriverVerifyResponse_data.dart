import 'Driver.dart';
import 'package:get_in/models/data.dart';
class DriverVerifyResponse_data {
  DriverVerifyResponse_data({
    this.success,
    this.message,
    this.data,
    this.status,
  });
  bool success;
  String message;
  Data data;
  int status;

  get get_message1 {
    return message;
  }

  set set_message1(String value) {
    message = value;
  }

  factory DriverVerifyResponse_data.fromJson(Map<String, dynamic> json) =>
      DriverVerifyResponse_data(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
    "status": status,
  };
}

DriverVerifyResponse_data collect_response1;

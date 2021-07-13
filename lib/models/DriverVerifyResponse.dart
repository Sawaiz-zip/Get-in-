import 'Driver.dart';
import 'package:get_in/models/data.dart';


class DriverVerifyResponse {
  DriverVerifyResponse({
    this.success,
    this.message,
    //  this.data,
    this.status,
  });
  bool success;
  String message;
  //Data data;
  int status;

  get set_message1 {
    return message;
  }

  set set_message1(String value) {
    message = value;
  }

  factory DriverVerifyResponse.fromJson(Map<String, dynamic> json) =>
      DriverVerifyResponse(
        success: json["success"],
        message: json["message"],
        //      data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
//    "data": data.toJson(),
    "status": status,
  };
}


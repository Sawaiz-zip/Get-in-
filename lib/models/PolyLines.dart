import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Polylines {
  Polylines(
      {this.distance_Text,
      this.distance_Value,
      this.duration_Text,
      this.duration_Value,
      this.polylines_Points,
      this.end_address,
      this.start_address,
      this.end_location_lat,
      this.end_location_lng,
      this.start_location_lat,
      this.start_location_lng});
  String polylines_Points;
  String distance_Text;
  int distance_Value;
  String duration_Text;
  int duration_Value;
  String end_address;
  String start_address;
  double end_location_lat;
  double end_location_lng;
  double start_location_lat;
  double start_location_lng;
}

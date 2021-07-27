import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_in/Google_maps.dart';


class GeolocatorService
{

  Future<Position> get_current_position()async
  {

    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}


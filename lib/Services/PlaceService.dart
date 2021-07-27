import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:get_in/models/Place_search.dart';
import 'package:get_in/models/Place.dart';
import 'package:get_in/models/PolyLines.dart';
class PlaceService {
  final key = 'AIzaSyAaWgEcW7gJYCGLKMILz1MyLrQC1v-kAdw';

  Future<List<Place_Search>> getAutocomplete(String search) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=AIzaSyAaWgEcW7gJYCGLKMILz1MyLrQC1v-kAdw';
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => Place_Search.fromjson(place)).toList();
  }

  Future<Place> getPlace(String place_id) async {
    print('placeid------>$place_id');
    String url =
'https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAaWgEcW7gJYCGLKMILz1MyLrQC1v-kAdw&place_id=$place_id' ;
      var response = await http.get(Uri.parse(url));
    print('Place_id_respose${response.body}');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResults);
  }
  Future<Polylines>  obtain_Direction_Details(LatLng initialPosition,LatLng finalPosition)async
  {
    String Url="https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=AIzaSyAaWgEcW7gJYCGLKMILz1MyLrQC1v-kAdw";
    http.Response response = await http.get(Uri.parse(Url));
    var json = convert.jsonDecode(response.body);
    Map values= convert.jsonDecode(response.body);
Polylines polylines=Polylines();

polylines.polylines_Points=values["routes"][0]["overview_polyline"]["points"];
polylines.duration_Text=values["routes"][0]["legs"][0]["duration"]["text"];
polylines.distance_Value=values["routes"][0]["legs"][0]["duration"]["value"];
    polylines.distance_Text=values["routes"][0]["legs"][0]["distance"]["text"];
    polylines.distance_Value=values["routes"][0]["legs"][0]["distance"]["value"];
    polylines.end_address=values["routes"][0]["legs"][0]["end_address"];
    polylines.start_address=values["routes"][0]["legs"][0]["start_address"];
polylines.start_location_lng=values["routes"][0]["legs"][0]["start_location"]["lng"];
    polylines.start_location_lat=values["routes"][0]["legs"][0]["start_location"]["lat"];
    polylines.end_location_lng=values["routes"][0]["legs"][0]["end_location"]["lng"];
    polylines.end_location_lat=values["routes"][0]["legs"][0]["end_location"]["lat"];

    return polylines;



  }


}

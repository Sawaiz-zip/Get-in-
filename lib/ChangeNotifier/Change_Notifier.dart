import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_in/Services/Locate_position.dart';
import 'package:get_in/Services/PlaceService.dart';
import 'package:get_in/models/Place_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_in/models/Place.dart';

class Change_Notifier with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placeService = PlaceService();
  Position current_location;
  LatLng current_coordinates;
  List<Place_Search> searchResults;
  Place place;
  StreamController<Place> selectedLocation = StreamController<Place>();
  Change_Notifier() {
    Set_current_location();
  }

  Set_current_location() async {
    current_location = await geolocatorService.get_current_position();
    LatLng Current_Coordinates =
        LatLng(current_location.latitude, current_location.longitude);
    notifyListeners();
  }

  SearchPlaces(String searchTerm) async {
    print('searchTerm=====>>>>$searchTerm');
    searchResults = await placeService.getAutocomplete(searchTerm);
    print('search results==>>>>>>>>>>>>$searchResults');
    notifyListeners();
  }
  set_Selected_Location(String place_id)async{
    selectedLocation.add(await placeService.getPlace(place_id));
     place=await placeService.getPlace(place_id);

    searchResults=null;
    notifyListeners();
  }


  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}

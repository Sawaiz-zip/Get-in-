import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_in/ChangeNotifier/Change_Notifier.dart';
import 'package:get_in/Services/PlaceService.dart';
import 'package:get_in/models/PolyLines.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:get_in/models/Place.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_in/Services/Firebase_Messaging.dart';
class Google_Maps extends StatefulWidget {
  const Google_Maps({Key key}) : super(key: key);

  @override
  _Google_MapsState createState() => _Google_MapsState();
}

class _Google_MapsState extends State<Google_Maps> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersistantBottomSheetCallBack;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController _googleMapController;
  CameraPosition _initialCameraPosition;
  String search_value;
  int tapindex;
  String destination;
  Place placelatlng;
  Polylines details;
  List<LatLng> pline_Coordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker>markers={};
  Set<Circle>circles={};

  StreamSubscription locationSubscription;
  @override
  void initState() {
    var geoLocator = Geolocator(); // INSTANCE OF GEOLOCATOR()

    final changenotifier = Provider.of<Change_Notifier>(context, listen: false);

    locationSubscription =
        changenotifier.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    final changenotifier = Provider.of<Change_Notifier>(context, listen: false);
    changenotifier.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    final changenotifier = Provider.of<Change_Notifier>(context);
    LatLng Currentposition_Coordinates;
    return Scaffold(
      drawer: Firebase_Messaging(),
      appBar: AppBar(
        title: Text('Get in!'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      key: _scaffoldKey,
      body: (changenotifier.current_location == null)
          ? Center(child: CircularProgressIndicator())
          :  Container(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    height: _size.height,
    width: _size.width,
    color: Colors.white,

    child: Stack(children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                mapToolbarEnabled: false,
                zoomGesturesEnabled: true,
                polylines: polylineSet,
                markers: markers,
                circles: circles,
                initialCameraPosition: CameraPosition(
                    target: LatLng(changenotifier.current_location.latitude,
                        changenotifier.current_location.longitude),
                    zoom: 8),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),

        Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 40, right: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Search Location',
                          suffixIcon: Icon(Icons.search),
                          fillColor: Colors.white.withOpacity(0.6),
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Where to?',
                         // suffixText: destination != null ? destination : '',
                          labelStyle: new TextStyle(
                              color: Colors.black, fontSize: 16.0)),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          search_value = value;
                        });
                        changenotifier.SearchPlaces(value);
                      },
                    ),
                  ),
                  Stack(children: [
                    changenotifier.searchResults != null &&
                            changenotifier.searchResults.length != 0 &&
                            search_value != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 40, left: 40),
                            child: Container(
                                height: 300,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  backgroundBlendMode: BlendMode.darken,
                                  borderRadius: new BorderRadius.circular(20),
                                )),
                          )
                        : SizedBox(
                            height: 300,
                          ),
                    changenotifier.searchResults != null &&
                            changenotifier.searchResults.length != 0 &&
                            search_value != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 40, left: 40),
                            child: Container(
                              height: 300,
                              child: ListView.builder(
                                  itemCount:
                                      changenotifier.searchResults.length,
                                  itemBuilder: (context, index) {
                                    print(changenotifier
                                        .searchResults[index].description);
                                    return ListTile(
                                      title: Text(
                                        changenotifier
                                            .searchResults[index].description,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        changenotifier.set_Selected_Location(
                                            changenotifier
                                                .searchResults[index].place_id);
                                        setState(() {
                                          tapindex = index;

                                          getPlaceDirection().whenComplete(() {


                                            if (details.start_address != null &&
                                                details.end_address != null) {
                                              destination = details.end_address;
                                              _scaffoldKey.currentState
                                                  .showBottomSheet((context) {
                                                return new Container(
                                                  height: 250.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius: new BorderRadius
                                                              .only(
                                                          topRight: const Radius
                                                              .circular(20.0),
                                                          topLeft: const Radius
                                                              .circular(20.0)),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Color(0xffD22129),)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Your Location ",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(0xffD22129)),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          " ${details.start_address}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Destination ",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(0xffD22129)),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          " ${details.end_address}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            " Distance: ",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(0xffD22129)),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            " ${details.distance_Text}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Center(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  " Duration: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(0xffD22129)),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                Text(
                                                                  " ${details.duration_Text}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      RaisedButton(
                                                        onPressed: () {
                                                          if (details
                                                              .polylines_Points
                                                              .isNotEmpty) {
                                                            getpolylines();
                                                            _showPersistantBottomSheetCallBack =
                                                                null;

                                                          } else
                                                            AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                            );
                                                        },
                                                        child: Text('Confirm'),
                                                        color: Color(0xffD22129),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            }
                                            else
                                              {
                                                 AlertDialog(
                                                  title: Text('Error'),
                                                );
                                              }
                                          });

                                          // destination = changenotifier
                                          //     .searchResults[index].description;
                                          _showPersistantBottomSheetCallBack =
                                              null;
                                        });

                                        print(
                                            'Your Location=${changenotifier.current_location}');
                                      },
                                    );
                                  }),
                            ),
                          )
                        : SizedBox(
                            height: 300,
                          ),
                  ]),
                ],
              ),
              Positioned(
                bottom: 100,
                right: 15,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100, right: 10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    onPressed: () {
                      changenotifier.Set_current_location();
                      print(changenotifier.current_location);
                      //_initialCameraPosition=CameraPosition(target: LatLng(changenotifier.current_location.longitude,changenotifier.current_location.latitude),zoom:2);

                      setState(() {
                        CameraPosition _current_camera_position =
                            CameraPosition(
                                target: LatLng(
                                    changenotifier.current_location.latitude,
                                    changenotifier.current_location.longitude),
                                zoom: 15);
                        _goToPlace_gps(_current_camera_position);
                      });

                      print(changenotifier.current_location);
                    },
                    child: const Icon(Icons.gps_fixed),
                  ),
                ),
              ),
            ]),
    ),);
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 15)));
    print(place.name);
  }

  Future<void> _goToPlace_gps(CameraPosition camposition) async {
    final GoogleMapController controller = await _mapController.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(camposition.target.latitude, camposition.target.longitude),
        zoom: 15)));
  }

  Future<Polylines> getPlaceDirection() async {
    final changenotifier = Provider.of<Change_Notifier>(context, listen: false);
    PlaceService places = PlaceService();
    placelatlng =
        await places.getPlace(changenotifier.searchResults[tapindex].place_id);
    print('destination_lat:${placelatlng.geometry.location.lat}');
    print('destination_lng:${placelatlng.geometry.location.lng}');
    print('Your Location=${changenotifier.current_location}');
    var Pickup_latlng = LatLng(changenotifier.current_location.latitude,
        changenotifier.current_location.longitude);
    var Dropoff_latlng = LatLng(
        placelatlng.geometry.location.lat, placelatlng.geometry.location.lng);

    details =
        await places.obtain_Direction_Details(Pickup_latlng, Dropoff_latlng);
    print('details========${details.start_location_lng}');
  }

  void getpolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedpolylinePoints =
        polylinePoints.decodePolyline(details.polylines_Points);
    pline_Coordinates.clear();
    if (decodedpolylinePoints.isNotEmpty) {
      decodedpolylinePoints.forEach((PointLatLng pointLatLng) {
        pline_Coordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
      polylineSet.clear();
      setState(() {
        Polyline polyline = Polyline(
            color: Colors.blueAccent,
            polylineId: PolylineId("PolylineId"),
            jointType: JointType.round,
            points: pline_Coordinates,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            geodesic: true,
            onTap: () {});
        polylineSet.add(polyline);
      });
      LatLngBounds latLngBounds;
      if (details.start_location_lat > details.end_location_lat &&
          details.start_location_lng > details.end_location_lng) {
        latLngBounds = LatLngBounds(
            southwest:
                LatLng(details.end_location_lat, details.end_location_lng),
            northeast:
                LatLng(details.start_location_lat, details.start_location_lng));
      } else if (details.start_location_lng > details.end_location_lng) {
        latLngBounds = LatLngBounds(
            southwest:
                LatLng(details.start_location_lat, details.end_location_lng),
            northeast:
                LatLng(details.end_location_lat, details.start_location_lng));
      } else if (details.start_location_lat > details.end_location_lat) {
        latLngBounds = LatLngBounds(
            southwest:
                LatLng(details.end_location_lat, details.start_location_lng),
            northeast:
                LatLng(details.start_location_lat, details.end_location_lng));
      } else {
        latLngBounds = LatLngBounds(
            southwest:
                LatLng(details.start_location_lat, details.start_location_lng),
            northeast:
                LatLng(details.end_location_lat, details.end_location_lng));
      }
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 120));
      Marker pickUpLocMarker=Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: details.start_address,snippet: "Your Location"),
        position: LatLng(details.start_location_lat,details.start_location_lng),
        markerId: MarkerId("PickUpId"),

      );
      Marker dropOffLocMarker=Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    infoWindow: InfoWindow(title: details.end_address,snippet: "DropOff Location"),
    position: LatLng(details.end_location_lat,details.end_location_lng),
    markerId: MarkerId("DropOffId"),
      );
      setState(() {
        markers.add(pickUpLocMarker);
        markers.add(dropOffLocMarker);
      });
      Circle pickUpCircle=Circle(
        fillColor: Colors.blue,
        center: LatLng(details.start_location_lat,details.start_location_lng),
        radius: 12,
        strokeColor: Colors.black,
        strokeWidth: 4,
        circleId: CircleId("PickUpId"),


      );
      Circle droffOffCircle=Circle(
        fillColor: Colors.red,
        center: LatLng(details.end_location_lat,details.end_location_lng),
        radius: 12,
        strokeColor: Colors.black,
        strokeWidth: 4,
        circleId: CircleId("DropOffId"),


      );
      setState(() {
        circles.add(pickUpCircle);
        circles.add(droffOffCircle);
      });
    }
  }
}

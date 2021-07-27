class Location
{
  final double lat;
  final double lng;
  Location({this.lat,this.lng});
  factory Location.fromjson(Map<dynamic,dynamic>parsedJson){
    return Location(
      lat: parsedJson['lat'],
      lng: parsedJson['lng']
    );
  }
}
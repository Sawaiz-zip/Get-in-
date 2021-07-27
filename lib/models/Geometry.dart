import 'package:geolocator/geolocator.dart';
import 'package:get_in/models/Location.dart';
import 'Location.dart';
class Geometry
{
  final Location location;
Geometry({this.location});
factory Geometry.fromJson(Map<dynamic,dynamic>parsedJson){
  return Geometry(
    location: Location.fromjson(parsedJson['location'])
  );
}
}
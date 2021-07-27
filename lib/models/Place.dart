import 'package:get_in/models/Geometry.dart';

class Place
{
  final Geometry geometry;
  final String name;
  final String vacinity;
  Place({this.geometry,this.name,this.vacinity});
  factory Place.fromJson(Map<String,dynamic>parsedJson){
    return Place(
geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['formatted_address'],
      vacinity: parsedJson['vacinity']
    );

}
}

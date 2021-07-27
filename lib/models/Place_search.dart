import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 class Place_Search
 {
   String description;
   String place_id;

   Place_Search({this.description,this.place_id});

   factory Place_Search.fromjson(Map<String,dynamic>json){
     return Place_Search(
       description: json['description'],
       place_id: json['place_id']
     );
   }
 }
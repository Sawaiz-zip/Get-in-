import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;




Future<Response> apiRequest(
    String endPoint, String method, Map body) async {
  String LocalConstants ='http://192.168.0.161/projects/get-in-ride-service';
  Uri.parse('');
  String C = LocalConstants+ endPoint;
  Uri url=Uri.parse(C);
  try {
    if (method == 'post') {
      print('Post');
      final resp = await http.post(
          url,

          body: body
      );
      print(resp.body);
      return resp;
    }
    else if(method=='get')
    {
      final resp_get=await http.get(url);
      return resp_get;
    }
    else{
      final resp_put=await http.put(url,
      body: body
      );
      return resp_put;
    }
  } catch (e) {
    print('General Error: $e');
  }
}


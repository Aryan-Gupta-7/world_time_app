import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location image for UI
  String? time; //time in that location
  String flag; //url to asset of the flag
  String url; // location url for api endpoint
  bool? isDayTime; // true if day false if night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      //make the request
      Response response = await get(Uri.https('worldtimeapi.org', '/api/timezone/$url'));
      Map data = jsonDecode(response.body) as Map;

      //get properties from data
      String datetime = data['datetime'];
      int x = int.parse(datetime.substring(11,13));
      isDayTime = x>6 && x<20 ? true:false;
      time = datetime.substring(11,19);
    }

    catch(e){
      print("Error Occured: $e");
      time = 'Could not get time';
    }

  }
}
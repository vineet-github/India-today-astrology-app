import 'dart:convert';
import 'dart:io';

import 'package:astrology_app/constants.dart';
import 'package:astrology_app/models/astrologer.dart';
import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/models/panchang.dart';
import 'package:astrology_app/repos.dart';


import 'package:http/http.dart' as http;



class Repository implements LocationsRepo,PanchangRepo,AstrologerRepo{

List<Location> locations=[];


Future<List<Location>> fetchLocationsList (String locationname) async{


  var client = http.Client();
  try {
    var uriResponse = await client.get(Uri.parse(LOCATIONS_URL+"inputPlace="+locationname),);
 //   print(uriResponse.body);

   // var encoded = json.encode(uriResponse.body);
    // data = json.encode(encoded);
    var data = json.decode(uriResponse.body);
    var data2=data["data"];

    for(var u in data2){
      String locname=u['placeName'].toString();
      String locationid=u['placeId'].toString();

      Location location=Location(locationid, locname);
      locations.add(location);
    }

    print(data2.toString());
    print("Location_list_length"+locations.length.toString());
   // print(await client.get(uriResponse.body);
    return locations;
  } finally {
  client.close();
  }






}


Future<Panchang> fetchPanchang(Location location,String day,String month,String year) async{
 // var client = http.Client();
  print('LocId'+location.locationid.toString());
  try {
    Map data = {
      'day': day, 'month': month,'year':year,'placeId':location.locationid.toString()
    };




    var uriResponse = await http.post(Uri.parse(PANCHANG_URL),
        body:json.encode({
          "day":day,"month":month,"year":year,"placeId":location.locationid.toString()
        }) ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
       print(uriResponse.body);
       print(json.encode({
         "day":day,"month":month,"year":year,"placeId":location.locationid.toString()
       }));

    // var encoded = json.encode(uriResponse.body);
    // data = json.encode(encoded);
    var data1 = json.decode(uriResponse.body);
    Panchang panchang=Panchang.fromJson(data1);
   /* var data2=data["data"];

    for(var u in data2){
      String locname=u['placeName'].toString();
      String locationid=u['placeId'].toString();

      Location location=Location(locationid, locname);
      locations.add(location);
    }

    print(data2.toString());*/
  //  print("Location_list_length"+locations.length.toString());
    // print(await client.get(uriResponse.body);
    return panchang;
  } finally {
   // client.close();
  }

}

  @override
  Future<Astrologer> fetchAstrologers() async{
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse(ASTROLOGERS_URL),);
         print(uriResponse.body);

      // var encoded = json.encode(uriResponse.body);
      // data = json.encode(encoded);
      var data = json.decode(uriResponse.body);
      Astrologer astrologer=Astrologer.fromJson(data);
      return astrologer;


    } finally {
      client.close();
    }




  }

















}
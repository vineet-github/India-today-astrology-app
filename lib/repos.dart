

import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/models/panchang.dart';

import 'models/astrologer.dart';

abstract class LocationsRepo{

  Future<List<Location>> fetchLocationsList(String locationname);
}


abstract class PanchangRepo{
  Future<Panchang> fetchPanchang(Location location,String day,String month,String year);
}

abstract class AstrologerRepo{
  Future<Astrologer> fetchAstrologers();
}
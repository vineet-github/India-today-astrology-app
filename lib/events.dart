

import 'package:astrology_app/models/location.dart';

enum LocationEvents {
  fetchLocations,
}

enum PanchangEvents{
  fetchPanchang,
}

enum AstrologerEvents{
  fetchAstrologers,
}



class LocationEvent{

  final Location location;
  final LocationEvents locationEvents;
  LocationEvent({required this.location,required this.locationEvents});

}

class PanchangEvent{
  final Location location;
  final String day;
  final String month;
  final String year;
  final PanchangEvents panchangEvents;
  PanchangEvent({required this.location,required this.panchangEvents,required this.day,required this.month,required this.year});
}

class AstrologerEvent{
  final AstrologerEvents astrologerEvents;
  AstrologerEvent({required this.astrologerEvents});
}


import 'package:astrology_app/events.dart';
import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/repos.dart';
import 'package:astrology_app/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsBloc extends Bloc<LocationEvent,LocationState>{
final LocationsRepo locationsRepo;
//final String locationname;
List<Location> locations=[];
  LocationsBloc({required this.locationsRepo}):super(LocationsInitState());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async*{
    if(event.locationEvents==LocationEvents.fetchLocations){
      yield LocationsLoading();
      try {
        locations = await locationsRepo.fetchLocationsList(event.location.locationname.toString());

        yield LocationsLoaded(locations);

      }catch (e) {
        print(e.toString());
        yield LocationsListError(error: e);
      }




    }
  }

  
  
  
  
}
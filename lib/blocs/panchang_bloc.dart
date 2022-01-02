


import 'package:astrology_app/events.dart';
import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/models/panchang.dart';
import 'package:astrology_app/repos.dart';
import 'package:astrology_app/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanchangBloc extends Bloc<PanchangEvent,PanchangState>{
  final PanchangRepo panchangRepo;

 late Panchang panchang;

  PanchangBloc({required this.panchangRepo}):super(PanchangInitState());
  @override
  Stream<PanchangState> mapEventToState(PanchangEvent event) async*{
    if(event.panchangEvents==PanchangEvents.fetchPanchang){
      yield PanchangLoading();
      try {
        panchang = await panchangRepo.fetchPanchang(event.location,event.day,event.month,event.year);

        yield PanchangLoaded(panchang);

      }catch (e) {
        print(e.toString());
        yield PanchangError(error: e);
      }




    }





  }







}
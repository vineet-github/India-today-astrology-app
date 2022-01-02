

import 'package:astrology_app/events.dart';
import 'package:astrology_app/models/astrologer.dart';
import 'package:astrology_app/repos.dart';
import 'package:astrology_app/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AstrologersBloc extends Bloc<AstrologerEvent,AstrologersState>{
  final AstrologerRepo astrologerRepo;
  late Astrologer astrologer;

  AstrologersBloc({required this.astrologerRepo}):super(AstrologersInitState());
  @override
  Stream<AstrologersState> mapEventToState(AstrologerEvent event) async*{
    if(event.astrologerEvents==AstrologerEvents.fetchAstrologers){
      yield AstrologersLoading();
      try {
        astrologer = await astrologerRepo.fetchAstrologers();

        yield AstrologersLoaded(astrologer);

      }catch (e) {
        print(e.toString());
        yield AstrologersError(error: e);
      }
  }




}}
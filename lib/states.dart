

import 'package:astrology_app/models/astrologer.dart';
import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/models/panchang.dart';
import 'package:equatable/equatable.dart';

class LocationState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];

}



class LocationsInitState extends LocationState {}
class LocationsLoading extends LocationState {}
class LocationsLoaded extends LocationState {
  final List<Location> locations;


  LocationsLoaded(this.locations);
}


class LocationsListError extends LocationState {
  final error;
  LocationsListError({this.error});
}

class PanchangState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class PanchangInitState extends PanchangState{

}

class PanchangLoading extends PanchangState{

}

class PanchangLoaded extends PanchangState{
  final Panchang panchang;
  PanchangLoaded(this.panchang);
}


class PanchangError extends PanchangState{
  final error;
  PanchangError({this.error});
}


class AstrologersState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class AstrologersInitState extends AstrologersState{

}

class AstrologersLoading extends AstrologersState{

}

class AstrologersLoaded extends AstrologersState{
  final Astrologer astrologer;
  AstrologersLoaded(this.astrologer);
}

class AstrologersError extends AstrologersState{
  final error;
  AstrologersError({this.error});
}


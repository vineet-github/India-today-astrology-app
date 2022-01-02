class Location{

String ?locationid;
String ?locationname;


Location(String ?locationid,String ? locationname){
  this.locationid=locationid;
  this.locationname=locationname;

}


@override
String toString() {
  return locationname!.toLowerCase() + locationname!.toUpperCase();
}

@override
bool operator ==(Object other) =>
    identical(this, other) ||
        other is Location &&
            runtimeType == other.runtimeType &&
            locationid == other.locationid;

@override
int get hashCode => locationid.hashCode;





}
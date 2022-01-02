import 'package:astrology_app/blocs/astrologers_bloc.dart';
import 'package:astrology_app/blocs/locations_bloc.dart';
import 'package:astrology_app/blocs/panchang_bloc.dart';
import 'package:astrology_app/events.dart';
import 'package:astrology_app/models/location.dart';
import 'package:astrology_app/repos.dart';
import 'package:astrology_app/repository.dart';
import 'package:astrology_app/states.dart';
import 'package:astrology_app/talk_to_astrologer.dart';
import 'package:astrology_app/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'constants.dart';
import 'models/panchang.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: colorCustom,
      ),
      home:MultiBlocProvider(providers: [

      BlocProvider(
      create: (context) => LocationsBloc(locationsRepo: Repository()),
    child: MyHomePage(title: "",),
    ),
        BlocProvider(
          create: (context) => PanchangBloc(panchangRepo: Repository()),
          child: MyHomePage(title: "",),
        ),
        BlocProvider(
          create: (context) => AstrologersBloc(astrologerRepo: Repository()),
          child: TalkToAstrologer(),
        )

    ],child: MyHomePage(title: "",),
    ),);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var selecteddate=DateFormat('dd MMMM,yyyy').format(DateTime.now());
  Location currentLocation=Location("0", "Delhi");
  String day="";
  String month="";
  String year="";
  late List<Map<String, Widget>> _pages;
  int selectedIndex = 0;
  AstrologersBloc ?astrologersBloc;

  List<Location> locations=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  astrologersBloc=AstrologersBloc(astrologerRepo: Repository());
    context.bloc<LocationsBloc>().add(LocationEvent(location: currentLocation, locationEvents: LocationEvents.fetchLocations));

  }

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex.toString());
    });

    if(selectedIndex==1){
      Utility.CallNavigator(context, TalkToAstrologer(), context);

    }

  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<DateTime ?> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget ? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
  }
  _pickDate() async {

    var order = await getDate();
    setState(() {


      selecteddate = DateFormat('dd MMMM,yyyy').format(order);
      day=order!.day.toString();
      month=order.month.toString();
      year=order.year.toString();
      print("Day "+day+"Month "+month+"Year "+year);

      //yyyy-MM-dd




    });

  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false, centerTitle: true,leading:  Container(child:
      Image.asset("assets/hamburger.png",height: 25,)
      ),

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(mainAxisSize: MainAxisSize. min, children: [
          Container(child:
          Image.asset("assets/logo.png",height: 40,)
          )

        ],),actions: [
           IconButton(onPressed: (){}, icon: Container(child:
           Image.asset("assets/profile.png",height: 40,)
           ))
      ],

      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            onTap: selectedPage,
            backgroundColor: Colors.white,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor: Colors.orange,
            currentIndex: 0,
            showSelectedLabels: true,

            items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/home.png",height: 20,), tooltip: 'Home', label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/talk.png",height:20),tooltip: 'Talk to Astrolger', label: 'Talk'),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/ask.png",height:20), tooltip: 'Ask Question', label: 'Ask Question'),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/reports.png",height:20), tooltip: 'Reports', label: 'Reports'),
            ],
          ),
        ),
      ),
      body:  SingleChildScrollView(child:Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[
            BlocBuilder<LocationsBloc, LocationState>(

                builder: (BuildContext context, LocationState state) {
                  print("StateIs"+state.toString());

                  if (state is LocationsListError) {
                    final error = state.error;
                    String message = '${error.message}\nTap to Retry.';
                    print(message);
                  }
                  else if (state is LocationsLoaded) {

                     locations = state.locations;


                    print("StateIs"+state.toString());
                    return  Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children:[       Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,8.0,0,0),
                      child: Row(children: [
                        Icon(Icons.arrow_back_ios,size: 18,) ,Text("Daily Panchang",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                      ],),
                    ),
                      Expanded(flex: 0,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("India is a country known for its festival but knowing the exact dates can sometimes be difficult .To ensure you donot miss out on critical dates we bring out the daily panchang.",style: TextStyle(fontSize: 13,color: textColor),),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Container(decoration:BoxDecoration(color: Colors.orangeAccent),height: 150,width: 500,child: Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children:[

                          Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [ Padding(
                            padding: const EdgeInsets.fromLTRB(20.0,10,10,10),
                            child: Text("Date :",style: TextStyle(fontSize: 16),),
                          ) ,  Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,10,10,10),

                            child: Container(decoration:BoxDecoration(color: Colors.white),height: 40,width: 250,child:GestureDetector(
                                onTap: () {
                                  _pickDate();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0,5,10,10),
                                  child: Text(selecteddate,style: TextStyle(fontSize: 20),
                                  ),
                                ))),


                          )],),
                          Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0,10,10,10),
                              child: Text("Location :",style: TextStyle(fontSize: 16),),
                            ) ,Expanded(child:Container(width:600,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(

                                    0, 10, 20, 0),
                                child:Container(decoration:BoxDecoration(color: Colors.white),height: 50,width: 160,child:IgnorePointer(ignoring: false,


                                    child: SearchableDropdown(
                                      underline: SizedBox(),
                                      value: currentLocation,
                                      onChanged: (value) {
                                        currentLocation =
                                            value;
                                        print(currentLocation.locationid);

                                        context.bloc<LocationsBloc>().add(LocationEvent(location: currentLocation, locationEvents: LocationEvents.fetchLocations));

                                        context.bloc<PanchangBloc>().add(PanchangEvent(location: currentLocation, panchangEvents: PanchangEvents.fetchPanchang,day: day,month: month,year: year));








                                      },

                                      items: locations.map((item) {
                                        return new DropdownMenuItem<
                                            Location>(
                                            child: SizedBox(
                                                width: 200,
                                                child: Text(
                                                    item.locationname.toString())),
                                            value: item);
                                      }).toList(),
                                      isExpanded: true,
                                      hint: 'Select Location',
                                      isCaseSensitiveSearch: false,
                                      searchHint: new Text(
                                        'Select Location',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: colorCustom),
                                      ),
                                    )),

                              ))))]),









                      BlocBuilder<PanchangBloc,PanchangState>(builder:  (BuildContext context, PanchangState state){
                        if (state is PanchangError) {
                          final error = state.error;
                          String message = '${error.message}\nTap to Retry.';
                          print(message);
                        }else if(state is PanchangLoaded){
                          Panchang panchang=state.panchang;
                          return  Column(children: [
                            SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children: [
                              Row(children: [
                                Icon(Icons.wb_sunny),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Sunrise"),Text(panchang.data!.sunrise.toString())
                                ],)

                              ],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 1, height:30,color: Colors.black),
                              ),
                              Row(children: [
                                Icon(Icons.wb_sunny),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Sunset"),Text(panchang.data!.sunset.toString())
                                ],)

                              ],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 1, height:30,color: Colors.black),
                              ),
                              Row(children: [
                                Icon(Icons.nightlight_round),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Moonrise"),Text(panchang.data!.moonrise.toString())
                                ],)

                              ],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 1, height:30,color: Colors.black),
                              ),
                              Row(children: [
                                Icon(Icons.nights_stay_outlined),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Moonset"),Text(panchang.data!.moonset.toString())
                                ],)

                              ],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 1, height:30,color: Colors.black),
                              ),

                              Row(children: [
                                Icon(Icons.wb_sunny_outlined),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Vedic Sunrise"),Text(panchang.data!.vedicSunrise.toString())
                                ],)

                              ],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 1, height:30,color: Colors.black),
                              ),
                              Row(children: [
                                Icon(Icons.wb_sunny_outlined),Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
                                  Text("Vedic Sunset"),Text(panchang.data!.vedicSunset.toString())
                                ],)

                              ],),






                            ],)),

                            Column(children: [
                              Text("Tithi",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Tithi Number :"),Text(panchang.data!.tithi!.details!.tithiNumber.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Tithi Name :"),Text(panchang.data!.tithi!.details!.tithiName.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Special"),Text(panchang.data!.tithi!.details!.special.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Summary :"),Expanded(child:Text(panchang.data!.tithi!.details!.summary.toString()))


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Deity :"),Text(panchang.data!.tithi!.details!.deity.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End Time :"),Text(panchang.data!.tithi!.endTime!.hour.toString()+"hr "+panchang.data!.tithi!.endTime!.minute.toString()+"min "+panchang.data!.tithi!.endTime!.minute.toString()+"sec")


                                ],),
                              )



                            ],),
                            Column(children: [
                              Text("Nakshatra",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Nakshatra Number:"),Text(panchang.data!.nakshatra!.detailsSecond!.nakNumber.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Nakshatra Name :"),Text(panchang.data!.nakshatra!.detailsSecond!.nakName.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Ruler"),Text(panchang.data!.nakshatra!.detailsSecond!.ruler.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Deity :"),Text(panchang.data!.nakshatra!.detailsSecond!.deity.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Special :"),Text(panchang.data!.nakshatra!.detailsSecond!.special.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Summary :"),Expanded(child:Text(panchang.data!.nakshatra!.detailsSecond!.summary.toString()))


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End Time :"),Text(panchang.data!.tithi!.endTime!.hour.toString()+"hr "+panchang.data!.tithi!.endTime!.minute.toString()+"min "+panchang.data!.nakshatra!.endTime!.second.toString()+"sec")


                                ],),
                              )



                            ],),
                            Column(children: [
                              Text("Yog",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Yoga Number:"),Text(panchang.data!.yog!.detailsThird!.yogNumber.toString())


                                ],),
                              ),

                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Yoga Name"),Text(panchang.data!.yog!.detailsThird!.yogName.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Special :"),Text(panchang.data!.yog!.detailsThird!.special.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Meaning :"),Expanded(child:Text(panchang.data!.yog!.detailsThird!.meaning.toString()))


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End Time :"),Text(panchang.data!.yog!.endTime!.hour.toString()+"hr "+panchang.data!.yog!.endTime!.minute.toString()+"min "+panchang.data!.yog!.endTime!.second.toString()+"sec")


                                ],),
                              )



                            ],),
                            Column(children: [
                              Text("Karan",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Karan Number :"),Text(panchang.data!.karan!.detailsFourth!.karanNumber.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Karan Name :"),Text(panchang.data!.karan!.detailsFourth!.karanName.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Special"),Expanded(child:Text(panchang.data!.karan!.detailsFourth!.special.toString()))


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Deity :"),Text(panchang.data!.karan!.detailsFourth!.deity.toString())


                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End Time :"),Text(panchang.data!.karan!.endTime!.hour.toString()+"hr "+panchang.data!.karan!.endTime!.minute.toString()+"min "+panchang.data!.karan!.endTime!.second.toString()+"sec")



                                ],),
                              ),




                            ],),
                            Column(children: [
                              Text("Hindu Maah",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Adhik Status :"),Text(panchang.data!.hinduMaah!.adhikStatus.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Purnimanta :"),Text(panchang.data!.hinduMaah!.purnimanta.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Amanta"),Text(panchang.data!.hinduMaah!.amanta.toString())


                                ],),
                              ),




                            ],),
                            Column(children: [

                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Paksha:"),Text(panchang.data!.paksha.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Ritu :"),Text(panchang.data!.ritu.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Sunsign"),Text(panchang.data!.sunSign.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Moonsign"),Text(panchang.data!.moonSign.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Ayana"),Text(panchang.data!.ayana.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Panchang Yog"),Text(panchang.data!.panchangYog.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Vikram Samvat"),Text(panchang.data!.vikramSamvat.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Shaka samvat"),Text(panchang.data!.shakaSamvatName.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Disha Shool"),Text(panchang.data!.dishaShool.toString())


                                ],),
                              ),
                              Padding(
                                padding: const  EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Disha Shool remedies"),Text(panchang.data!.dishaShool.toString())


                                ],),
                              ),




                            ],),
                            Column(children: [
                              Text("Abhijit Muhurata",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Start :"),Text(panchang.data!.abhijitMuhurta!.start.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End :"),Text(panchang.data!.abhijitMuhurta!.start.toString())


                                ],),
                              ),





                            ],),
                            Column(children: [
                              Text("Rahukaal",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Start :"),Text(panchang.data!.rahukaal!.start.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End :"),Text(panchang.data!.rahukaal!.end.toString())


                                ],),
                              ),





                            ],),
                            Column(children: [
                              Text("Gulikaal",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Start :"),Text(panchang.data!.guliKaal!.start.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End :"),Text(panchang.data!.guliKaal!.end.toString())


                                ],),
                              ),





                            ],),
                            Column(children: [
                              Text("Yamghanta kaal",style: TextStyle(fontSize: 18,color: Colors.black),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("Start :"),Text(panchang.data!.yamghantKaal!.start.toString())


                                ],),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(10.0,10,0,5),
                                child: Row(children: [
                                  Text("End Time :"),Text(panchang.data!.yamghantKaal!.end.toString())


                                ],),
                              ),





                            ],),
                          ],);


                        }
                        return CircularProgressIndicator();

                      }




                      )])))]);


                  }

                  return CircularProgressIndicator();

                }),




          ],
        )),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.view_headline),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:astrology_app/blocs/astrologers_bloc.dart';
import 'package:astrology_app/events.dart';
import 'package:astrology_app/models/astrologer.dart';
import 'package:astrology_app/repository.dart';
import 'package:astrology_app/states.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'constants.dart';

class TalkToAstrologer extends StatefulWidget{

  TalkToAstrologerScreen createState()=> TalkToAstrologerScreen();
}

class TalkToAstrologerScreen extends State{
  int selectedIndex = 0;
  AutoCompleteTextField ?searchTextField;
  bool futurebool=false;
  List<Data> astrologerslist=[];
  List<Data> filteredastrologerslist=[];
  GlobalKey<AutoCompleteTextFieldState<Data>> key = new GlobalKey();
  AstrologersBloc ?astrologersBloc;



  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });

    if(selectedIndex==1){

    }else if(selectedIndex==0){
        Navigator.pop(context);
    }

  }

  Future<void> fetchAllAstrologers(BuildContext? buildContext) async {

   buildContext.bloc<AstrologersBloc>().add(AstrologerEvent(astrologerEvents: AstrologerEvents.fetchAstrologers));


  }


  Future<void> fetchFilteredList() async{

    print('filtered_list_size'+filteredastrologerslist.length.toString());


  }




  @override
  Widget build(BuildContext context) {

   BuildContext? buildContext= ModalRoute.of(context)!.settings.arguments as BuildContext?;
   astrologersBloc=BlocProvider.of(buildContext);




    return FutureBuilder(future: futurebool?fetchFilteredList():fetchAllAstrologers(buildContext),builder:(context,snapshot){
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
            currentIndex: 1,
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
      body: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Text("Talk to an Astrologer",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),Spacer(),Image.asset("assets/search.png",height: 20,),Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Image.asset("assets/filter.png",height: 20,),
              ),
            ),Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:GestureDetector(onTap: (){

                setState(() {
                  astrologerslist.sort((a, b) => a.experience!.compareTo(b.experience!));
                });
              },child:  Image.asset("assets/sort.png",height: 20,)),
            )
          ],),

        ),
        Expanded(flex: 0,
          child: Padding(
            padding:
            const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
                child: (Container(
                  child:searchTextField = AutoCompleteTextField<Data>(
                      textChanged: (String str){
                        if(str==''){
                          filteredastrologerslist=astrologerslist;
                          setState(() {

                          });

                          /*     futurebool=false;
                                        stockpickinglist.clear();
                                        setState(() {


                                        });*/

                        }else{
                          futurebool=true;
                          str=str.toLowerCase();
                          setState(() {

                              filteredastrologerslist=astrologerslist.where((element){
                                var name=  element.firstName!.toLowerCase();
                                print(name.toString());
                                return name.contains(str);
                              }).toList();


                         //   print('filtered_list_inside'+filteredstockpickinglist.length.toString());
                          });


                        }

                      },

                      style: new TextStyle(color: Colors.black, fontSize: 15.0),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(
                            15,  // HERE THE IMPORTANT PART
                          ), border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorCustom, //this has no effect
                        ),

                        borderRadius: BorderRadius.circular(2.0),
                      ),hintText: 'Search'),

                      itemSubmitted: (item) {

                          setState(() => searchTextField!.textField.controller!.text =
                              item.firstName!);



                      },
                      clearOnSubmit: false,

                      suggestions:filteredastrologerslist,
                      itemBuilder: (context, item) {

                        print("Filtered_items"+item.firstName.toString());
                        print(filteredastrologerslist.length.toString());
                        return Container();
                        //stockpickinglist.add(item);




                      },
                      itemSorter: (a, b) {

                          return a.firstName!.compareTo(b.firstName!);


                      },

                      itemFilter: (item, query) {

                          return item.firstName!
                              .toLowerCase()
                              .startsWith(query.toLowerCase());

                      }),))),
          ),
        ),

        BlocBuilder<AstrologersBloc,AstrologersState>(cubit:astrologersBloc,builder:  (buildContext, AstrologersState state){
      if (state is AstrologersError) {
      final error = state.error;
      String message = '${error.message}\nTap to Retry.';
      print(message);
      }else if(state is AstrologersLoaded){
        print("Astrologers Loaded");
        astrologerslist=state.astrologer.data!;
   return   Expanded(child:
      ListView.separated(
      itemBuilder: (BuildContext ctxt, int index) {

      return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
      child: Card(
      //                           <-- Card

      child:GestureDetector( onTap :(){
  //    Utility.CallNavigator(ctxt, IncomingStockForm(),futurebool?filteredstockpickinglist.elementAt(index):incomingstockitems.elementAt(index));





      },
      child:Row( children:[Expanded(flex:1,child: Image.network(astrologerslist.elementAt(index).images!.medium!.imageUrl.toString(),width: 70,height: 70,)),Expanded(flex: 2,child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Container(
      decoration: BoxDecoration(
      color: colorCustom,
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4)),
      boxShadow: [
      BoxShadow(
      color: Colors.black12, blurRadius: 5)
      ],
      ),
      child:                                   new Row(
      children: <Widget>[
      Expanded(
      child: new Container(
      child: Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: new RichText(
      //data.taskname.toString()
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      strutStyle: StrutStyle(fontSize: 15.0),
      text: TextSpan(
      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      text: futurebool?filteredastrologerslist.elementAt(index).firstName!+" "+filteredastrologerslist.elementAt(index).lastName!:astrologerslist.elementAt(index).firstName!+" "+astrologerslist.elementAt(index).lastName!),
      ),
      )))
      ],
      ),
      ),

      Divider(
      height: 0.5,
      color: Colors.white,
      ),
      new Row(
      children: <Widget>[
      Expanded(
      child: new Container(
      child: Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: new RichText(
      //data.taskname.toString()
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      strutStyle: StrutStyle(fontSize: 15.0),
      text: TextSpan(
      style: TextStyle(color: Colors.black),
      text: futurebool?filteredastrologerslist.elementAt(index).aboutMe:astrologerslist
          .elementAt(index)
          .aboutMe),
      ),
      )))
      ],
      ),
        Divider(
          height: 0.5,
          color: Colors.white,
        ),
        new Row(
          children: <Widget>[
            Expanded(
                child: new Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: new RichText(
                        //data.taskname.toString()
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        strutStyle: StrutStyle(fontSize: 15.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: futurebool?filteredastrologerslist.elementAt(index).experience.toString()+" years":astrologerslist
                                .elementAt(index)
                                .experience.toString()+" years"),
                      ),
                    )))
          ],
        ),
      new Row(
      children: <Widget>[
      Expanded(
      child: new Container(
      child: Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: new RichText(
      //data.taskname.toString()
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      strutStyle: StrutStyle(fontSize: 15.0),
      text: TextSpan(
      style: TextStyle(color: Colors.black),
      text: futurebool?'\u{20B9}'+filteredastrologerslist.elementAt(index).additionalPerMinuteCharges.toString()+"/"+"Min":'\u{20B9}'+astrologerslist
          .elementAt(index)
          .additionalPerMinuteCharges.toString()+"/"+"Min"),
      ),
      )))
      ],
      ),
        ElevatedButton.icon(
          label: Text('Talk On Call',style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.phone,color: Colors.white,),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
            ),
          onPressed: () {
            print('Pressed');
          },
        )
      ]))])),
      /*title: Text(measureList.elementAt(index).startdate,
                                     ),*/
      ),
      );
      },
      separatorBuilder: (context, index) {
      return Divider(color: Colors.white);
      },
      itemCount: futurebool? filteredastrologerslist.length:astrologerslist.length));



      }




return CircularProgressIndicator();
        }
        )],),
    );});


  }





}
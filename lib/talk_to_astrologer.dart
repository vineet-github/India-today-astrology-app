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
<<<<<<< HEAD
  String skillsstr="";
  String filteredskillsstr="";
  String filteredlanguagestr="";
  String languagestr="";
  List<String> choices = <String>[
    "Search Criteria",
    "Name",
    "Skills",
    "Languages",
  ];

  List<String> sortchoices = <String>[
    "Search Criteria",
    "Experience High to Low",
    "Experience Low to High",
    "Price High to Low",
    "Price Low to High"
  ];

  String _selectedChoices='';
  String _selectedSortChoice='';

  void _select(String choice) {

    _selectedChoices=choice;
    print(choice);
    print(_selectedChoices);
  }

  void _selectSortFilter(String choice){
    _selectedSortChoice=choice;
    print(_selectedSortChoice);
    if(_selectedSortChoice=="Experience High to Low"){
      setState(() {
        astrologerslist.sort((a, b) => b.experience!.compareTo(a.experience!));
      });
    }else if(_selectedSortChoice=="Experience Low to High"){
      setState(() {
        astrologerslist.sort((a, b) => a.experience!.compareTo(b.experience!));
      });

    }else if(_selectedSortChoice=="Price High to Low"){
      setState(() {
        astrologerslist.sort((a, b) => b.additionalPerMinuteCharges!.compareTo(a.additionalPerMinuteCharges!));
      });
    }else if(_selectedSortChoice=="Price Low to High"){
      setState(() {
        astrologerslist.sort((a, b) => a.additionalPerMinuteCharges!.compareTo(b.additionalPerMinuteCharges!));
      });
    }

  }

=======
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a



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
<<<<<<< HEAD
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
              child: PopupMenuButton(
                onSelected: _selectSortFilter,
                padding: EdgeInsets.zero,
                initialValue: sortchoices[0],
                icon: Image.asset("assets/sort.png",height: 20,),
                itemBuilder: (BuildContext context) {
                  return sortchoices.map((String choice) {
                    return  PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),

                    );}

                  ).toList();
                },
              ),
=======
            ),Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child:GestureDetector(onTap: (){

                setState(() {
                  astrologerslist.sort((a, b) => a.experience!.compareTo(b.experience!));
                });
              },child:  Image.asset("assets/sort.png",height: 20,)),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
            )
          ],),

        ),
<<<<<<< HEAD
        Row(children:[Expanded(
=======
        Expanded(flex: 0,
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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

<<<<<<< HEAD

=======
                          /*     futurebool=false;
                                        stockpickinglist.clear();
                                        setState(() {


                                        });*/
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a

                        }else{
                          futurebool=true;
                          str=str.toLowerCase();
                          setState(() {
<<<<<<< HEAD
                              if(_selectedChoices=="Name"){
                                filteredastrologerslist=astrologerslist.where((element){
                                  var name=  element.firstName!.toLowerCase();
                                  print(name.toString());
                                  return name.contains(str);
                                }).toList();
                              }else if(_selectedChoices=="Skills"){
                                filteredastrologerslist=astrologerslist.where((element){
                                  var name=  element.skillsstr!.toLowerCase();
                                  print(name.toString());
                                  return name.contains(str);
                                }).toList();


                              }else if(_selectedChoices=="Languages"){
                                filteredastrologerslist=astrologerslist.where((element){
                                  var name=  element.languagesstr!.toLowerCase();
                                  print(name.toString());
                                  return name.contains(str);
                                }).toList();

                              }else{
                                filteredastrologerslist=astrologerslist.where((element){
                                  var name=  element.firstName!.toLowerCase();
                                  print(name.toString());
                                  return name.contains(str);
                                }).toList();
                              }




=======

                              filteredastrologerslist=astrologerslist.where((element){
                                var name=  element.firstName!.toLowerCase();
                                print(name.toString());
                                return name.contains(str);
                              }).toList();


                         //   print('filtered_list_inside'+filteredstockpickinglist.length.toString());
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD
                          if(_selectedChoices=="Name"){
                            setState(() => searchTextField!.textField.controller!.text =
                            item.firstName!);
                          }else if(_selectedChoices=="Skills"){
                            setState(() => searchTextField!.textField.controller!.text =
                            item.skillsstr!);
                          }else if(_selectedChoices=="Languages"){
                            setState(() => searchTextField!.textField.controller!.text =
                            item.languagesstr!);
                          }else{
                            setState(() => searchTextField!.textField.controller!.text =
                                item.firstName!);
                          }

=======

                          setState(() => searchTextField!.textField.controller!.text =
                              item.firstName!);
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a



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
<<<<<<< HEAD
                          if(_selectedChoices=="Name"){
                            return a.firstName!.compareTo(b.firstName!);
                          }else if(_selectedChoices=="Skills"){
                            return a.skillsstr!.compareTo(b.skillsstr!);
                          }else if(_selectedChoices=="Languages"){
                            return a.languagesstr!.compareTo(b.languagesstr!);
                          }else{
                            return a.firstName!.compareTo(b.firstName!);
                          }

=======

                          return a.firstName!.compareTo(b.firstName!);
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a


                      },

                      itemFilter: (item, query) {
<<<<<<< HEAD
                          if(_selectedChoices=="Name"){
                            return item.firstName!
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          }else if(_selectedChoices=="Skills"){
                            return item.skillsstr!
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          }else if(_selectedChoices=="Languages"){
                            return item.languagesstr!
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          }else{
                            return item.firstName!
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          }


                      }),))),
          ),
        ), PopupMenuButton(
          onSelected: _select,
          padding: EdgeInsets.zero,
          initialValue: choices[0],
          icon: Icon(Icons.filter,color: Colors.black26,size: 20,) ,
          itemBuilder: (BuildContext context) {
            return choices.map((String choice) {
              return  PopupMenuItem<String>(
                value: choice,
                child: Text(choice),

              );}

            ).toList();
          },
        )]),
=======

                          return item.firstName!
                              .toLowerCase()
                              .startsWith(query.toLowerCase());

                      }),))),
          ),
        ),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a

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
<<<<<<< HEAD
        if(futurebool){
          List<Skills>? skills=filteredastrologerslist.elementAt(index).skills;
       //   filteredskillsstr="";
          filteredastrologerslist.elementAt(index).skillsstr="";
          for(int i=0;i<skills!.length;i++){

            filteredastrologerslist.elementAt(index).skillsstr=filteredastrologerslist.elementAt(index).skillsstr!+(skills.elementAt(i).name.toString()+",");
          }
          print("Skill array"+filteredastrologerslist.elementAt(index).skillsstr.toString());
          List<Languages>? languages=filteredastrologerslist.elementAt(index).languages;
        //  filteredlanguagestr="";
          filteredastrologerslist.elementAt(index).languagesstr="";
          for(int i=0;i<languages!.length;i++){
            filteredastrologerslist.elementAt(index).languagesstr=filteredastrologerslist.elementAt(index).languagesstr!+(languages.elementAt(i).name.toString()+",");
          }
          print("Languages arr"+filteredastrologerslist.elementAt(index).languagesstr.toString());
        }else{
          List<Skills>? skills=astrologerslist.elementAt(index).skills;
         // skillsstr="";
          astrologerslist.elementAt(index).skillsstr="";
          for(int i=0;i<skills!.length;i++){

            astrologerslist.elementAt(index).skillsstr=astrologerslist.elementAt(index).skillsstr!+(skills.elementAt(i).name.toString()+",");
          }
          print("Skill array"+astrologerslist.elementAt(index).skillsstr.toString());
          List<Languages>? languages=astrologerslist.elementAt(index).languages;
         // languagestr="";
          astrologerslist.elementAt(index).languagesstr="";
          for(int i=0;i<languages!.length;i++){
            astrologerslist.elementAt(index).languagesstr=astrologerslist.elementAt(index).languagesstr!+(languages.elementAt(i).name.toString()+",");
          }
          print("Languages arr"+astrologerslist.elementAt(index).languagesstr.toString());
        }

=======
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a

      return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
      child: Card(
      //                           <-- Card

      child:GestureDetector( onTap :(){
<<<<<<< HEAD
=======
  //    Utility.CallNavigator(ctxt, IncomingStockForm(),futurebool?filteredstockpickinglist.elementAt(index):incomingstockitems.elementAt(index));
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a





      },
<<<<<<< HEAD
      child:Row( children:[Expanded(flex:1,child: futurebool?Image.network(filteredastrologerslist.elementAt(index).images!.medium!.imageUrl.toString(),width: 70,height: 70,):Image.network(astrologerslist.elementAt(index).images!.medium!.imageUrl.toString(),width: 70,height: 70,)),Expanded(flex: 2,child:Column(
=======
      child:Row( children:[Expanded(flex:1,child: Image.network(astrologerslist.elementAt(index).images!.medium!.imageUrl.toString(),width: 70,height: 70,)),Expanded(flex: 2,child:Column(
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD

=======
      //data.taskname.toString()
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD
      const EdgeInsets.fromLTRB(20, 5, 10, 5),
=======
      const EdgeInsets.fromLTRB(20, 10, 20, 10),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
      child: new RichText(
      //data.taskname.toString()
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      strutStyle: StrutStyle(fontSize: 15.0),
      text: TextSpan(
      style: TextStyle(color: Colors.black),
<<<<<<< HEAD
      text: futurebool?filteredastrologerslist.elementAt(index).skillsstr:astrologerslist.elementAt(index).skillsstr),
=======
      text: futurebool?filteredastrologerslist.elementAt(index).aboutMe:astrologerslist
          .elementAt(index)
          .aboutMe),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD
                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: new RichText(

                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        strutStyle: StrutStyle(fontSize: 15.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: futurebool?filteredastrologerslist.elementAt(index).languagesstr:astrologerslist.elementAt(index).languagesstr),
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
                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: new RichText(

=======
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: new RichText(
                        //data.taskname.toString()
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        strutStyle: StrutStyle(fontSize: 15.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
<<<<<<< HEAD
                            text: futurebool?filteredastrologerslist.elementAt(index).experience.toString()+" years":astrologerslist.elementAt(index).experience.toString()+" years"),
=======
                            text: futurebool?filteredastrologerslist.elementAt(index).experience.toString()+" years":astrologerslist
                                .elementAt(index)
                                .experience.toString()+" years"),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD
      const EdgeInsets.fromLTRB(20, 5, 20, 5),
=======
      const EdgeInsets.fromLTRB(20, 10, 20, 10),
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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
<<<<<<< HEAD
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0,5,20,5),
          child: ElevatedButton.icon(
            label: Text('Talk On Call',style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.phone,color: Colors.white,),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),
            onPressed: () {
              print('Pressed');
            },
          ),
=======
        ElevatedButton.icon(
          label: Text('Talk On Call',style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.phone,color: Colors.white,),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
            ),
          onPressed: () {
            print('Pressed');
          },
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
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




<<<<<<< HEAD
return CircularProgressIndicator(color: Colors.orange,);
=======
return CircularProgressIndicator();
>>>>>>> 8e0b630e17c0d7f2162c4b6ce7b3ece05105133a
        }
        )],),
    );});


  }





}
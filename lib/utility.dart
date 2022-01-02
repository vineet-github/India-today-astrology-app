import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Utility{




  static void CallNavigator(BuildContext buildContext,Widget widget,Object object){
    Navigator.push(
      buildContext,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(
          arguments:object,
        ),

      ),
    );


  }






}
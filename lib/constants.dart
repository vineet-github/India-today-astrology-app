import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



const String LOCATIONS_URL="https://www.astrotak.com/astroapi/api/location/place?";
const String ASTROLOGERS_URL="https://www.astrotak.com/astroapi/api/agent/all";
const String PANCHANG_URL="https://www.astrotak.com/astroapi/api/horoscope/daily/panchang";

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
const MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
const MaterialColor textColor = MaterialColor(0xFFBDBDBD, color);


const Color themecolor = Color(0xFF0078D7);

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final dark_softUI = new NeumorphicStyle(
  shape: NeumorphicShape.flat,
  color: Color.fromRGBO(30, 31, 35,1.0),
  shadowDarkColor: Color.fromRGBO(25, 26, 30, 1.0),
  shadowLightColor: Color.fromRGBO(45, 46, 50,1.0),
  depth: 10,
  lightSource: LightSource.topLeft,
  intensity: 1
);

final light_softUI = new NeumorphicStyle(
  shape: NeumorphicShape.flat,
  color: Color.fromRGBO(225, 230, 236, 1.0),
  shadowDarkColor: Color.fromRGBO(205, 210, 215, 1.0),
  shadowLightColor: Color.fromRGBO(240 , 242, 244, 1.0),
  depth: 10,
  lightSource: LightSource.topLeft,
  intensity: 1
);

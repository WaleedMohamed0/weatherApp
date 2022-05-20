import 'package:flutter/material.dart';

Text myTxt({required String txt, required double fontSize, FontWeight? fontWeight,Color color= Colors.white,List<Shadow>? Shadow,double? letterSpacing})
{
  return Text(
    txt,
  style: TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    shadows: Shadow,
    letterSpacing: letterSpacing,
  ),
);
}



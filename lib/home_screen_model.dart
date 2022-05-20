import 'package:flutter/material.dart';

class HomeScreenModel {
  String name;
  double temp;
  String speed;
  String weatherCondition;
  String clouds;
  String humidity;


  HomeScreenModel({
    required this.name,
    required this.temp,
    required this.speed,
    required this.weatherCondition,
    required this.clouds,
    required this.humidity,
  });
}

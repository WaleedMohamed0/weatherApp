import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/API.dart';
import 'package:untitled7/cubit/cubit.dart';
import 'package:untitled7/home_screen.dart';

void main() async{
  runApp(BlocProvider(
      create: (context)=>AppCubit()..getWeatherData(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),);
  }
}

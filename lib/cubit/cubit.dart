import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:untitled7/API.dart';
import 'package:untitled7/cubit/states.dart';
import 'package:untitled7/home_screen_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool Fetched = false;
  bool gotLocation = false;
  HomeScreenModel uiModel = new HomeScreenModel(
      name: "",
      temp: 1,
      speed: "",
      weatherCondition: '',
      clouds: '',
      humidity: '',
);
List<double> dailyTemp=[1,2,3,4,5,5,7];
List<double> dailyNightTemp=[1,2,3,4,5,5,7];
List<String> dailyWeatherCond=['1','2','3','4','5','5','7'];
List<String> days=['Sat','Sun','Mon','Tue','Wed','Thu','Fri'];
List<String> currentWeekDays=[];

String formattedDay = DateFormat('EEEE').format(DateTime.now()).substring(0, 3);

String? lat,long;
Future<String> getLocation() async {
  LocationPermission permission;
  permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  lat = position.latitude.toString();
  long = position.longitude.toString();
  gotLocation = true;
  emit(gotLocationAppState());
  return '';
}


Future<Map<String, dynamic>> getData() async
{//30.033333 lat
  //31.233334 long
  // ba084a0dd485659e846540b89e0c79ea
  await getLocation();
  Response res = await Dio().get('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&units=metric&exclude=minutely,hourly&appid=ba084a0dd485659e846540b89e0c79ea');
  return res.data;
}


  void getWeatherData() async {
    emit(LoadingAppState());
    
    Map<String, dynamic> json = await getData();

    int currentDay = days.indexOf(formattedDay);
    if(currentWeekDays.isEmpty)
      {
        for(var i = currentDay;i<7;i++)
        {
          if(days.length != currentWeekDays.length)
            {
              currentWeekDays.add(days[i]);
              dailyTemp[i] = await json['daily'][i]['temp']['day'];
              dailyNightTemp[i] = await json['daily'][i]['temp']['night'] as double;
              dailyWeatherCond[i] = await json['daily'][i]['weather'][0]['main'];
            }
          else
            {
              break;
            }
          if(i==6)
            {
              i = -1;
            }
        }
      }


    uiModel = HomeScreenModel(
      name: json['timezone'].toString(),
      temp: json['current']['temp'],
      speed: json["current"]["wind_speed"].toString(),
      weatherCondition: json['current']['weather'][0]['main'].toString(),
      clouds: json['current']['clouds'].toString(),
      humidity: json['current']['humidity'].toString(),
    );
    emit(DataFetchedAppState());
    Fetched = true;
  }
}

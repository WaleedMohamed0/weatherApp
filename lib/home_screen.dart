import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:untitled7/API.dart';
import 'package:untitled7/components.dart';
import 'package:untitled7/cubit/cubit.dart';
import 'package:untitled7/cubit/states.dart';

String imgPath = "";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    String formattedDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());

    if (cubit.uiModel.weatherCondition == "Rain") {
      imgPath = 'assets/images/rainy_2d.png';
    } else if (cubit.uiModel.weatherCondition == "Snow") {
      imgPath = 'assets/images/snow_2d.png';
    } else if (cubit.uiModel.weatherCondition == "Thunderstorm") {
      imgPath = 'assets/images/thunder_2d.png';
    } else {
      imgPath = 'assets/images/sunny_2d.png';
    }
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingAppState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: DateTime.now().hour < 18
                  ? HexColor('01a1ff')
                  : HexColor('28345a'),
              leading: const Icon(Icons.grid_view),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 6,
                  ),
                  myTxt(
                      txt: cubit.uiModel.name.isNotEmpty
                          ? cubit.uiModel.name.substring(7)
                          : '',
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ],
              ),
              actions: const [
                Icon(Icons.more_vert),
                SizedBox(
                  width: 10,
                ),
              ],
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: DateTime.now().hour > 4 && DateTime.now().hour < 18
                        ? HexColor('01a1ff')
                        : HexColor('28345a'),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        if (!cubit.Fetched)
                          Container(
                              width: 135,
                              margin: const EdgeInsets.only(right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 0.3,
                                  color: Colors.white,
                                ),
                              ),
                              child: myTxt(
                                  txt: 'Updating..',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              padding: const EdgeInsets.only(left: 20, top: 5)),
                        SizedBox(
                          height: !cubit.Fetched ? 20 : 45,
                        ),
                        Image.asset(
                          (imgPath),
                          fit: BoxFit.fill,
                          width: 190,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        myTxt(
                            txt: cubit.uiModel.temp.round().toString() +
                                "\u00B0",
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            Shadow: [
                              const Shadow(
                                color: Colors.white,
                                blurRadius: 20,
                              )
                            ]),
                        myTxt(
                          txt: cubit.uiModel.weatherCondition,
                          fontSize: 23,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        myTxt(
                            txt: formattedDate,
                            fontSize: 16,
                            color: Colors.white),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    CupertinoIcons.wind,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: cubit.uiModel.speed + " m/s",
                                      fontSize: 15),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: "Wind",
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    CupertinoIcons.cloud,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: cubit.uiModel.clouds + " %",
                                      fontSize: 15),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: "Clouds",
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    CupertinoIcons.drop,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: cubit.uiModel.humidity + " %",
                                      fontSize: 15),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  myTxt(
                                      txt: "Humidity",
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myTxt(
                              txt: 'Forecast',
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          Row(
                            children: [
                              myTxt(
                                  txt: '7 days',
                                  fontSize: 17,
                                  color: Colors.grey),
                              const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: SizedBox(
                        height: 150,
                        child: ListView.separated(

                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 25,
                          ),
                          itemBuilder: (context, index) =>
                              cubit.currentWeekDays.isNotEmpty
                                  ? forecast(context, index)
                                  : const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

Widget forecast(context, index) {
  var cubit = AppCubit.get(context);
  if (index == 0) cubit.currentWeekDays[0] = "Today";
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(33),
      border: Border.all(
        width: 0.5,
        color: Colors.white,
      ),
    ),
    child: Column(
      children: [
        myTxt(
            txt: cubit.currentWeekDays[index],
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3),
        const SizedBox(
          height: 6,
        ),
        myTxt(
            txt: cubit.dailyTemp[index].round().toString() +
                "\u00B0" +
                "/" +
                cubit.dailyNightTemp[index].round().toString() +
                "\u00B0",
            fontSize: 16),
        const SizedBox(
          height: 13,
        ),
        Image.asset(
          imgPath,
          width: 50,
        ),
        const SizedBox(
          height: 13,
        ),
        myTxt(
            txt: cubit.dailyWeatherCond[index],
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ],
    ),
  );
}

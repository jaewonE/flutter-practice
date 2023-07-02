import 'package:flutter/material.dart';
import 'package:flutterpractice/widgets/city_list.dart';
import 'package:flutterpractice/widgets/weather_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final double mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(26, 29, 30, 1),
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(
                width: mediaWidth,
                height: mediaHeight,
                child: const WeatherDetail(),
              ),
              SizedBox(
                width: mediaWidth,
                height: mediaHeight,
                child: const CityList(),
              ),
            ],
          ),
        ));
  }
}

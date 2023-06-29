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
        body: SafeArea(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: mediaWidth,
            height: mediaHeight,
            color: const Color.fromRGBO(26, 29, 30, 1),
            child: const WeatherDetail(),
          ),
          Container(
            width: mediaWidth,
            height: mediaHeight,
            color: const Color.fromRGBO(26, 29, 30, 1),
            child: const CityList(),
          ),
        ],
      ),
    ));
  }
}

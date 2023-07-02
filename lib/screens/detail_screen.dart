import 'package:flutter/material.dart';
import 'package:flutterpractice/widgets/weather_detail.dart';

class DetailScreen extends StatelessWidget {
  final String city;

  const DetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(26, 29, 30, 1),
        body: SafeArea(
          child: WeatherDetail(city: city),
        ));
  }
}

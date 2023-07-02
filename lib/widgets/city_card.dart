import 'package:flutter/material.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:flutterpractice/services/unsplash_api_services.dart';
import 'package:flutterpractice/util/date_util.dart';

class CityCard extends StatefulWidget {
  final Weather weather;

  const CityCard({super.key, required this.weather});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  String? bgImage;

  void loadCityImage() async {
    var imageUrl =
        await UnsplashApiServices.getRandomCityImage(city: widget.weather.city);
    setState(() {
      bgImage = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCityImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: bgImage == null
          ? BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(16),
            )
          : BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(bgImage!), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(16),
            ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.weather.city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateUtility.getTimeString(widget.weather.forecastTime),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.weather.state,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.weather.temp.toInt()}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Max ${widget.weather.tempMax.toInt()}°  Min ${widget.weather.tempMin.toInt()}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

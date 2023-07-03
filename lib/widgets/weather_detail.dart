import 'package:flutter/material.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:flutterpractice/services/api_services.dart';
import 'package:flutterpractice/widgets/forecast_status_bar.dart';
import 'package:flutterpractice/widgets/weather_state_item.dart';
import 'package:flutterpractice/util/date_util.dart';

class WeatherDetail extends StatefulWidget {
  final String? city;

  const WeatherDetail({
    super.key,
    this.city,
  });

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  late Future<List<Weather>?> futureForecasts;
  late Future<Weather?> futureWeather;
  ValueNotifier<DateTime?> showDetailDate = ValueNotifier<DateTime?>(null);

  @override
  void initState() {
    super.initState();
    requestWeather(widget.city);
  }

  @override
  void dispose() {
    showDetailDate.dispose();
    super.dispose();
  }

  void requestWeather(String? city) {
    if (city == null) {
      futureWeather = ApiServices.getMyWeather();
      futureForecasts = ApiServices.getMyForecast();
    } else {
      futureWeather = ApiServices.getWeatherByCity(city: city);
      futureForecasts = ApiServices.getForecastByCity(city: city);
    }
  }

  void updateShowDetailDate(DateTime updateDate) {
    showDetailDate.value = updateDate;
  }

  void refreshLocation() => setState(() {
        requestWeather(widget.city);
      });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureWeather,
        builder: (context, weatherSnapshot) {
          if (weatherSnapshot.hasData) {
            return FutureBuilder(
              future: futureForecasts,
              builder: (context2, forecastsSnapshot) {
                if (forecastsSnapshot.hasData) {
                  final Weather weather = weatherSnapshot.data!;
                  final List<Weather> forecasts = forecastsSnapshot.data!;

                  DateTime startDate = forecasts[0].forecastTime;
                  DateTime endDate =
                      forecasts[forecasts.length - 1].forecastTime;
                  final dateDiff = endDate.difference(startDate).inDays + 2;

                  updateShowDetailDate(forecasts[0].forecastTime);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(weather.city,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 5),
                                  Text(
                                      '${weather.forecastTime.day} ${DateUtility.getMonthName(weather.forecastTime.month)}, ${DateUtility.getWeekdayName(weather.forecastTime.weekday)}',
                                      style: const TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(31, 35, 41, 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                    onPressed: refreshLocation,
                                    icon: const Icon(Icons.refresh_rounded,
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.7))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(' ${weather.temp.toInt()}°',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w900,
                                        )),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(weather.state,
                                      style: const TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Transform.translate(
                                offset: const Offset(-5, 0),
                                child: Transform.scale(
                                  scale: 1.6,
                                  child: SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.network(Weather.getIconUrl(
                                        icon: weather.icon,
                                        size: WeatherIconSize.big)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(31, 35, 41, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 6,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherStateItem(
                                      icon: Icon(
                                        Icons.thermostat_auto_outlined,
                                        color: Colors.red.shade300,
                                      ),
                                      state: 'Highest',
                                      value: '${weather.tempMax}°'),
                                  WeatherStateItem(
                                      icon: Icon(
                                        Icons.water_drop_outlined,
                                        color: Colors.blue.shade400,
                                      ),
                                      state: 'Humidity',
                                      value: '${weather.humidity}%'),
                                  WeatherStateItem(
                                      icon: Icon(
                                        Icons.tag_faces_outlined,
                                        color: Colors.purple.shade300,
                                      ),
                                      state: 'FeelsLike',
                                      value: weather.feelsLike.toString()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              for (var i = 0; i < dateDiff; i++)
                                ForecastStatusBar(
                                    showDetailDate: showDetailDate,
                                    updateShowDetailDate: updateShowDetailDate,
                                    forecasts: forecasts
                                        .where((forecast) =>
                                            DateUtility.isSameDay(
                                                forecast.forecastTime,
                                                startDate
                                                    .add(Duration(days: i))))
                                        .toList()),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

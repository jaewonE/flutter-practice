import 'package:flutter/material.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:flutterpractice/services/api_services.dart';
import 'package:flutterpractice/widgets/forecast_status_bar.dart';
import 'package:flutterpractice/widgets/weather_state_item.dart';

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
    var city = widget.city;
    if (city == null) {
      futureWeather = ApiServices.getMyWeather();
      futureForecasts = ApiServices.getMyForecast();
    } else {
      futureWeather = ApiServices.getWeatherByCity(city: city);
      futureForecasts = ApiServices.getForecastByCity(city: city);
    }
  }

  @override
  void dispose() {
    showDetailDate.dispose();
    super.dispose();
  }

  void updateShowDetailDate(DateTime updateDate) {
    showDetailDate.value = updateDate;
  }

  void refreshLocation() async {}

  bool isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

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

                  DateTime startDate = forecasts[0].forecastTime!;
                  DateTime endDate =
                      forecasts[forecasts.length - 1].forecastTime!;
                  final dateDiff = endDate.difference(startDate).inDays + 2;

                  updateShowDetailDate(forecasts[0].forecastTime!);

                  // weather.printInfo();

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hello world',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 5),
                                  Text('12 September, Sunday',
                                      style: TextStyle(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('18°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w900,
                                        )),
                                  ),
                                  SizedBox(height: 2),
                                  Text('Thunderstorm',
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              Transform.translate(
                                offset: const Offset(-5, 8),
                                child: Transform.scale(
                                  scale: 1.6,
                                  child: SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.network(
                                        'https://openweathermap.org/img/wn/10d@4x.png'),
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
                                      value: '20°'),
                                  WeatherStateItem(
                                      icon: Icon(
                                        Icons.water_drop_outlined,
                                        color: Colors.blue.shade400,
                                      ),
                                      state: 'Humidity',
                                      value: '84%'),
                                  WeatherStateItem(
                                      icon: Icon(
                                        Icons.tag_faces_outlined,
                                        color: Colors.purple.shade300,
                                      ),
                                      state: 'FeelsLike',
                                      value: '285.88'),
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
                                        .where((forecast) => isSameDay(
                                            forecast.forecastTime!,
                                            startDate.add(Duration(days: i))))
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

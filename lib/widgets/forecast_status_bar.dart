import 'package:flutter/material.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:flutterpractice/widgets/temp_by_time_item.dart';

class ForecastStatusBar extends StatefulWidget {
  final List<Weather> forecasts;
  final Function(DateTime) updateShowDetailDate;
  final ValueNotifier<DateTime?> showDetailDate;

  const ForecastStatusBar(
      {super.key,
      required this.forecasts,
      required this.updateShowDetailDate,
      required this.showDetailDate});

  @override
  State<ForecastStatusBar> createState() => _ForecastStatusBarState();
}

class _ForecastStatusBarState extends State<ForecastStatusBar> {
  late final int minTemp;
  late final int maxTemp;

  @override
  void initState() {
    super.initState();
    findMinMaxTemp();
  }

  bool isSameDay(
          DateTime? date1, DateTime? date2) =>
      date1 == null || date2 == null
          ? false
          : date1.year == date2.year &&
              date1.month == date2.month &&
              date1.day == date2.day;

  String getWeekdayName(int weekday) {
    // 당일 기준으로 5일치를 가져옴으로 요일이 같다면 오늘이다.
    if (DateTime.now().weekday == weekday) {
      return 'Today';
    }
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
    return '';
  }

  void findMinMaxTemp() {
    num min = widget.forecasts[0].tempMin;
    num max = widget.forecasts[0].tempMax;
    for (var i = 1; i < widget.forecasts.length; i++) {
      num targetMin = widget.forecasts[i].tempMin;
      num targetMax = widget.forecasts[i].tempMax;
      if (targetMin < min) min = targetMin;
      if (targetMax > max) max = targetMax;
    }
    minTemp = min.toInt();
    maxTemp = max.toInt();
  }

  String getIconUrl(String? icon) =>
      'https://openweathermap.org/img/wn/${icon ?? '01d'}@2x.png';

  double getBarWidth() {
    double sum = 0;
    sum += minTemp;
    if (sum % 2 == 0) {
      sum += widget.forecasts[0].forecastTime!.day.toDouble();
    } else {
      sum -= widget.forecasts[0].forecastTime!.day.toDouble();
    }
    if (sum % 2 == 0) {
      sum += maxTemp;
    } else {
      sum -= maxTemp;
    }
    if (sum == 0) sum = 44;
    if (sum < 0) sum *= -1;
    return sum.toInt() % 43 + 30;
  }

  @override
  Widget build(BuildContext context) {
    widget.showDetailDate.addListener(() {
      setState(() {});
    });
    return GestureDetector(
      onTap: () =>
          widget.updateShowDetailDate(widget.forecasts[0].forecastTime!),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(31, 35, 41, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 88,
                    child: Text(
                      getWeekdayName(widget.forecasts[0].forecastTime!.weekday),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text('$minTemp°',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      )),
                  const SizedBox(width: 4),
                  Container(
                    width: 88,
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: getBarWidth(),
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade300, Colors.blue.shade300],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Text('$maxTemp°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                  const SizedBox(width: 32),
                  Transform.scale(
                    scale: 2.4,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          Image.network(getIconUrl(widget.forecasts[0].icon)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height: isSameDay(widget.showDetailDate.value,
                      widget.forecasts[0].forecastTime)
                  ? 12
                  : 0),
          AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: isSameDay(widget.showDetailDate.value,
                      widget.forecasts[0].forecastTime)
                  ? 120
                  : 0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.forecasts.length,
                itemBuilder: (context, index) {
                  Weather forecast = widget.forecasts[index];
                  return TempByTimeItem(
                      hour: forecast.forecastTime!.hour,
                      weatherIcon: forecast.icon ?? '01d',
                      temp: forecast.temp);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
              )),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

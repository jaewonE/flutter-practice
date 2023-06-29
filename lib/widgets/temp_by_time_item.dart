import 'package:flutter/material.dart';

class TempByTimeItem extends StatelessWidget {
  final int hour;
  final String weatherIcon;
  final num temp;

  static String getIconUrl(String? icon) =>
      'https://openweathermap.org/img/wn/$icon@2x.png';

  const TempByTimeItem(
      {super.key,
      required this.hour,
      required this.weatherIcon,
      required this.temp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 120,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(31, 35, 41, 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hour <= 12
                  ? '$hour ${hour != 12 ? 'am' : 'pm'}'
                  : '${hour - 12} pm',
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            Transform.scale(
              scale: 2.5,
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.network(getIconUrl(weatherIcon)),
              ),
            ),
            const SizedBox(height: 16),
            Text(' $temp°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )),
          ],
        ),
      ),
    );
  }
}

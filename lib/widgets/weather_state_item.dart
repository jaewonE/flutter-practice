import 'package:flutter/material.dart';

class WeatherStateItem extends StatelessWidget {
  final Icon icon;
  final String state;
  final String value;

  const WeatherStateItem(
      {super.key,
      required this.icon,
      required this.state,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              )),
          const SizedBox(height: 6),
          Text(state,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: 12,
              )),
        ],
      ),
    );
  }
}

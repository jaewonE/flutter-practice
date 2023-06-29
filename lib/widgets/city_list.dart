import 'package:flutter/material.dart';

class CityList extends StatelessWidget {
  const CityList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'City 1',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 1000),
          Text(
            'City 1',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

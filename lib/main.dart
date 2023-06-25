// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  void countUp() {
    setState(() {
      count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$count',
                  style: const TextStyle(
                      fontSize: 104, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Click for count!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: IconButton(
                    onPressed: countUp,
                    icon: const Icon(
                      Icons.add_box_rounded,
                      size: 64,
                      color: Colors.blue,
                    )),
              )
            ],
          )
        ],
      )),
    );
  }
}

// main.dart
import 'dart:async';
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
  bool isPause = true;
  int leftSec = 1500; // 60x25
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      leftSec -= 1;
    });
  }

  void onPressed() {
    setState(() {
      if (isPause) {
        timer = Timer.periodic(const Duration(seconds: 1), onTick);
      } else {
        timer.cancel();
      }
      isPause = !isPause;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE7626C),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  Duration(seconds: leftSec)
                      .toString()
                      .split(".")
                      .first
                      .substring(2, 7),
                  style: const TextStyle(
                      color: Color(0xFFF4EDDB),
                      fontSize: 88,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              IconButton(
                  padding: const EdgeInsets.all(24),
                  onPressed: onPressed,
                  icon: Transform.translate(
                    offset: const Offset(-32, -32),
                    child: Icon(
                      isPause
                          ? Icons.play_circle_outline_outlined
                          : Icons.pause_circle_outline_outlined,
                      color: const Color(0xFFF4EDDB),
                      size: 88,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

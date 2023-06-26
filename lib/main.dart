import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterpractice/services/api_services.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  ApiServices().getForecastByCity(city: 'seoul');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Fultter!'),
        ),
        body: const Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}

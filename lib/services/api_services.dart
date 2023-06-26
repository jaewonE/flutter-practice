import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterpractice/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';

  String _coordQueryString(double lat, double lon) =>
      'lat=$lat&lon=$lon&lang=kr&appid=${dotenv.env['API_KEY']}';

  String _cityQueryString(String city, String country) =>
      'q=$city,$country&lang=kr&appid=${dotenv.env['API_KEY']}';

  // Get permission of getting location of user.
  // Return String if user denied or has error.
  Future<String?> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled. Please enable the services';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return null;
  }

  // Get weather by url
  Future<Weather?> _getWeather({required String url}) async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) return null;

    Weather weather = Weather.fromJson(jsonDecode(res.body));
    // weather.printInfo();
    return weather;
  }

  // get Forecast by url
  Future<List<Weather>?> _getForecast({required String url}) async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) return null;

    List<Weather> weatherList = [];
    var json = jsonDecode(res.body);
    List<dynamic> weatherListJson = json['list'];
    Map<String, dynamic> cityJson = json['city'];

    for (var i = 0; i < weatherListJson.length; i++) {
      weatherList.add(Weather.fromJson({...weatherListJson[i], ...cityJson}));
    }
    for (var i = 0; i < weatherListJson.length; i++) {
      weatherList[i].printInfo();
      print('\n');
    }
    return weatherList;
  }

  // Get weather by latitude and longitude.
  Future<Weather?> getWeather(
      {required double lat, required double lon}) async {
    return _getWeather(url: '$baseUrl/weather?${_coordQueryString(lat, lon)}');
  }

  // Get weather by current user location.
  Future<Weather?> getMyWeather() async {
    final permissionError = await _handleLocationPermission();
    if (permissionError != null) {
      print(permissionError);
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return getWeather(lat: position.latitude, lon: position.longitude);
  }

  // Get weather by city name
  Future<Weather?> getWeatherByCity(
      {required String city, String country = ''}) async {
    return _getWeather(
        url: '$baseUrl/weather?${_cityQueryString(city, country)}');
  }

  // Get 5-day weather forecast in 3-hour increments based on latitude and longitude
  Future<List<Weather>?> getForecast(
      {required double lat, required double lon}) async {
    return _getForecast(
        url: '$baseUrl/forecast?${_coordQueryString(lat, lon)}');
  }

  // Get 5-day weather forecast in 3-hour increments by city name
  Future<List<Weather>?> getForecastByCity(
      {required String city, String country = ''}) async {
    return _getForecast(
        url: '$baseUrl/forecast?${_cityQueryString(city, country)}');
  }
}

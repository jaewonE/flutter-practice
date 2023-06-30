enum WeatherIconSize { small, normal, big }

class Weather {
  final num lat;
  final num lon;
  final String state;
  final String description;
  final String? icon;
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num? humidity;
  final String city;

  final DateTime forecastTime;

  Weather.fromJson(Map<String, dynamic> json)
      : this.lat = json['coord']['lat'],
        this.lon = json['coord']['lon'],
        this.state = json['weather'][0]['main'],
        this.description = json['weather'][0]['description'],
        this.icon = json['weather'][0]['icon'],
        this.temp = json['main']['temp'],
        this.feelsLike = json['main']['feels_like'],
        this.tempMin = json['main']['temp_min'],
        this.tempMax = json['main']['temp_max'],
        this.humidity = json['main']['humidity'],
        this.city = json['name'] ?? '',
        this.forecastTime = json['dt_txt'] != null
            ? DateTime.parse(json['dt_txt'])
            : DateTime.fromMillisecondsSinceEpoch(json['dt']);

  static String getIconUrl({String? icon, WeatherIconSize? size}) {
    var baseUrl = 'https://openweathermap.org/img/wn/${icon ?? '01d'}';
    switch (size) {
      case null:
      case WeatherIconSize.normal:
        return '$baseUrl@2x.png';
      case WeatherIconSize.small:
        return '$baseUrl.png';
      case WeatherIconSize.big:
        return '$baseUrl@4x.png';
    }
  }

  void printInfo() {
    print(
        'lat: $lat\nlon: $lon\ncity: $city\nstate: $state\ndescription: $description\nicon: ${icon ?? 'null'}\ntemp: $temp\nfeelsLike: $feelsLike\ntempMin: $tempMin\ntempMax: $tempMax\nhumidity: ${humidity ?? 'null'}\nforecastTime: ${forecastTime.toString()}\n');
  }
}

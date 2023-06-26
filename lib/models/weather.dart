class Weather {
  final double lat;
  final double lon;
  final String state;
  final String description;
  final String? icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String city;

  final String? forecastTime;

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
        this.city = json['name'] ?? '',
        this.forecastTime = json['dt_txt'];

  void printInfo() {
    print(
        'lat: $lat\nlon: $lon\ncity: $city\nstate: $state\ndescription: $description\nicon: ${icon ?? 'null'}\ntemp: $temp\nfeelsLike: $feelsLike\ntempMin: $tempMin\ntempMax: $tempMax\n${forecastTime ?? 'forecastTime: $forecastTime\n'}');
  }
}

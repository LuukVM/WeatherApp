import 'package:equatable/equatable.dart';

class WeatherForecastModel extends Equatable {
  final String iconId;
  final num temperature;
  final DateTime time;
  final num probability;
  final num windSpeed;

  WeatherForecastModel({
    required this.iconId,
    required this.temperature,
    required this.time,
    required this.probability,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [this.time];

  // {"cod":"200",
  //"message":0,
  //"cnt":3,
  //"list":
  //[{
  //  "dt":1636988400,
  //  "main":
  //         {"temp":280.26,
  //          "feels_like":278.24,
  //          "temp_min":280.26,
  //          "temp_max":281.13,
  //          "pressure":1027,
  //          "sea_level":1027,
  //          "grnd_level":1024,
  //          "humidity":84,
  //          "temp_kf":-0.87},
  //  "weather":
  //          [{"id":803,
  //          "main":"Clouds",
  //          "description":"broken clouds",
  //          "icon":"04d"}],
  //  "clouds":{"all":60},
  //  "wind":{"speed":2.92,
  //          "deg":48,
  //          "gust":5.34},
  //  "visibility":10000,
  //  "pop":0,
  //  "sys":{"pod":"d"},
  //  "dt_txt":"2021-11-15 15:00:00"},

  factory WeatherForecastModel.fromJson(Map<String, dynamic> map) {
    return WeatherForecastModel(
      iconId: map['weather'][0]['icon'],
      temperature: map['main']['temp'].round(),
      time: DateTime.parse(map['dt_txt']),
      probability: (map['pop'] * 100).round(),
      windSpeed: (map['wind']['speed'] * 3.6).round(),
    );
  }
}

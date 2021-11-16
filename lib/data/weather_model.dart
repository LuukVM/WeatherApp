import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final int id;
  final String main;
  final String description;
  final String iconId;
  final num temperature;
  final num feelsLike;
  final int humidity;
  final num windSpeed;
  final int windDegree;
  final int clouds;
  final String locationName;
  final num? rain;
  final num? snow;

  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.iconId,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDegree,
    required this.clouds,
    required this.locationName,
    this.rain,
    this.snow,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'iconId': iconId,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'windDegree': windDegree,
      'clouds': clouds,
      'locationName': locationName,
      'rain': rain,
      'snow': snow,
    };
  }

  factory WeatherModel.fromApi(Map<String, dynamic> map) {
    return WeatherModel(
      id: map['id'],
      main: map['weather'][0]['main'],
      description: map['weather'][0]['description'],
      iconId: map['weather'][0]['icon'],
      temperature: map['main']['temp'].round(),
      feelsLike: map['main']['feels_like'].round(),
      humidity: map['main']['humidity'],
      windSpeed: (map['wind']['speed'] * 3.6).round(),
      windDegree: map['wind']['deg'],
      clouds: map['clouds']['today'] ?? map['clouds']['all'],
      locationName: map['name'],
      rain: map['rain'] != null ? map['rain']['1h'] : 0,
      snow: map['snow'] != null ? map['snow']['1h'] : 0,
    );
  }

  // [{id: 2759794,
  //dt: 1636546154,
  //name: Amsterdam,
  //coord: {Lon: 4.8897, Lat: 52.374},
  //main: {temp: 11.28, feels_like: 10.6, temp_min: 9.38, temp_max: 12.16, pressure: 1022, humidity: 82},
  //visibility: 10000,
  //wind: {speed: 2.68, deg: 199},
  //rain: null,
  //snow: null,
  //clouds: {today: 75},
  //weather: [{id: 803, main: Clouds, description: broken clouds, icon: 04d}]},

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: map['id'],
      main: map['main'],
      description: map['description'],
      iconId: map['iconId'],
      temperature: map['temperature'],
      feelsLike: map['feelsLike'],
      humidity: map['humidity'],
      windSpeed: map['windSpeed'],
      windDegree: map['windDegree'],
      clouds: map['clouds'],
      locationName: map['locationName'],
      rain: map['rain'],
      snow: map['snow'],
    );
  }

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [this.id];
}

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherProvider {
  final String apiKey = dotenv.env['OPEN_WEATHER_API'].toString();

  Future<String> getLocations() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/box/city?bbox=3.31497114423,50.803721015,7.183969,53.516937,15&appid=$apiKey'));

    return response.body;
  }

  Future<String> getIndividualLocations(cityIds) async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/group?id=$cityIds&units=metric&appid=$apiKey'));

    return response.body;
  }

  Future<String> getWeatherForecast(location) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$location&cnt=12&units=metric&appid=$apiKey'));

    return response.body;
  }
}

// 71-36 = 37
// 31-11 = 20

// 50°40'19.9"N 3°22'17.9"E 53.516937, 7.183969
// 53°31'01.0"N 7°11'02.3"E 50.672194, 3.371639

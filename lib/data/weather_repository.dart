import 'dart:convert';

import 'weather_forecast_model.dart';

import 'weather_model.dart';
import 'weather_provider.dart';

class WeatherRepository {
  final WeatherProvider _weatherProvider = WeatherProvider();

  Future<List<WeatherModel>> getAllWeatherLocations() async {
    List<WeatherModel> locations = [];

    String rawWeather = await _weatherProvider.getLocations();

    final rawWeatherData = json.decode(rawWeather);

    rawWeatherData['list'].forEach((location) {
      WeatherModel _location = WeatherModel.fromApi(location);
      locations.add(_location);
    });

    return locations;
  }

  Future<List<WeatherModel>> updateSelectedLocations(
      List<WeatherModel> selectedLocations) async {
    if (selectedLocations.isEmpty) {
      return [];
    }
    List<WeatherModel> locations = [];
    List<int> cityIds = [];
    selectedLocations.forEach((element) {
      cityIds.add(element.id);
    });

    String rawWeather =
        await _weatherProvider.getIndividualLocations(cityIds.join(","));

    final rawWeatherData = json.decode(rawWeather);

    rawWeatherData['list'].forEach((location) {
      WeatherModel _location = WeatherModel.fromApi(location);
      locations.add(_location);
    });

    return locations;
  }

  Future<List<WeatherForecastModel>> getWeatherForecast(location) async {
    List<WeatherForecastModel> forecasts = [];

    String rawWeather = await _weatherProvider.getWeatherForecast(location);

    final rawWeatherData = json.decode(rawWeather);

    rawWeatherData['list'].forEach((location) {
      WeatherForecastModel _location = WeatherForecastModel.fromJson(location);
      forecasts.add(_location);
    });

    return forecasts;
  }
}

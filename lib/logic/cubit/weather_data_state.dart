part of 'weather_data_cubit.dart';

abstract class WeatherDataState {}

class LoadingWeatherData extends WeatherDataState {}

class RetreiveWeatherDataSucces extends WeatherDataState {
  final List<WeatherModel> allLocations;

  RetreiveWeatherDataSucces({required this.allLocations});
}

class RetreiveWeatherDataFailed extends WeatherDataState {
  final String errorMessage;

  RetreiveWeatherDataFailed({required this.errorMessage});
}

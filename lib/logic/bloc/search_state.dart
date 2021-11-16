part of 'search_bloc.dart';

abstract class SearchState {}

class Searching extends SearchState {}

class SearchCompleted extends SearchState {
  final List<WeatherModel> foundLocations;

  SearchCompleted({required this.foundLocations});
}

class SearchFailed extends SearchState {
  final String errorMessage;

  SearchFailed({required this.errorMessage});
}

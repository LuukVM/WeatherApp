part of 'search_bloc.dart';

abstract class SearchEvent {}

class QueryChangedEvent extends SearchEvent {
  final String query;

  QueryChangedEvent({required this.query});
}

class InternetChangedEvent extends SearchEvent {
  final String errorMessage;

  InternetChangedEvent({required this.errorMessage});
}

class CreatedEvent extends SearchEvent {
  final List<WeatherModel> allLocations;

  CreatedEvent({required this.allLocations});
}

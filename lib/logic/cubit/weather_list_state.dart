part of 'weather_list_cubit.dart';

class WeatherListState {
  final List<WeatherModel> selectedLocations;

  WeatherListState({
    required this.selectedLocations,
  });

  Map<String, dynamic> toMap() {
    return {
      'selectedLocations': selectedLocations.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherListState.fromMap(Map<String, dynamic> map) {
    return WeatherListState(
      selectedLocations: List<WeatherModel>.from(
          map['selectedLocations']?.map((x) => WeatherModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherListState.fromJson(String source) =>
      WeatherListState.fromMap(json.decode(source));

  WeatherListState copyWith({
    List<WeatherModel>? selectedLocations,
  }) {
    return WeatherListState(
      selectedLocations: selectedLocations ?? this.selectedLocations,
    );
  }
}

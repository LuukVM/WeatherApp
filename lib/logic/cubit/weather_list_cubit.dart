import 'dart:async';
import 'dart:convert';

import 'package:bloc_cursus/constants/enums.dart';
import 'package:bloc_cursus/logic/cubit/internet_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/weather_repository.dart';

import '../../data/weather_model.dart';

part 'weather_list_state.dart';

class WeatherListCubit extends HydratedCubit<WeatherListState> {
  WeatherListCubit({required this.internetCubit})
      : super(WeatherListState(selectedLocations: []));
  WeatherRepository _weatherRepository = WeatherRepository();
  InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;

  void addWeatherLocation(WeatherModel location) {
    List<WeatherModel> newList = state.selectedLocations;
    newList.add(location);
    print("Added ${location.locationName}");
    emit(state.copyWith(selectedLocations: newList));
  }

  void deleteWeatherLocation(WeatherModel location) {
    List<WeatherModel> newList = state.selectedLocations;
    newList.remove(location);
    emit(state.copyWith(selectedLocations: newList));
  }

  void updateLocationsIndex(int oldIndex, int newIndex) {
    List<WeatherModel> newList = state.selectedLocations;
    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
    WeatherModel location = newList.removeAt(oldIndex);
    newList.insert(index, location);
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState.status == InternetStatus.connected &&
          internetState.connectionType == ConnectionType.Wifi) {
        emit(state.copyWith(selectedLocations: newList));
      }
    });
    if (internetCubit.state.status == InternetStatus.connected &&
        internetCubit.state.connectionType == ConnectionType.Wifi) {
      emit(state.copyWith(selectedLocations: newList));
    }
  }

  void updateLocations() async {
    List<WeatherModel> newList = await _weatherRepository
        .updateSelectedLocations(state.selectedLocations);

    emit(state.copyWith(selectedLocations: newList));
  }

  @override
  WeatherListState? fromJson(Map<String, dynamic> json) {
    return WeatherListState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WeatherListState state) {
    return state.toMap();
  }

  @override
  Future<void> close() {
    if (internetStreamSubscription != null) {
      internetStreamSubscription!.cancel();
    }
    return super.close();
  }
}

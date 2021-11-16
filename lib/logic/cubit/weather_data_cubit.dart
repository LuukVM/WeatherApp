import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../constants/enums.dart';
import '../../data/weather_model.dart';
import '../../data/weather_repository.dart';
import 'internet_cubit.dart';

part 'weather_data_state.dart';

class WeatherDataCubit extends Cubit<WeatherDataState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;
  WeatherRepository _weatherRepository = WeatherRepository();

  WeatherDataCubit({required this.internetCubit})
      : super(LoadingWeatherData()) {
    _subscribeToInternetCubit();
  }

  _subscribeToInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState.status == InternetStatus.connected &&
          internetState.connectionType == ConnectionType.Wifi) {
        emitRetrieveDataCompleted();
      } else if (internetState.status == InternetStatus.connected &&
          internetState.connectionType == ConnectionType.Mobile) {
        emitRetrieveDataFailed('Mobile data is enabled');
      } else if (internetState.status == InternetStatus.disconnected) {
        emitRetrieveDataFailed('No internet connection');
      }
    });
    if (internetCubit.state.status == InternetStatus.connected &&
        internetCubit.state.connectionType == ConnectionType.Wifi) {
      emitRetrieveDataCompleted();
    }
  }

  void emitRetrieveDataCompleted() async {
    emit(LoadingWeatherData());
    List<WeatherModel> locations =
        await _weatherRepository.getAllWeatherLocations();
    emit(RetreiveWeatherDataSucces(allLocations: locations));
  }

  void emitRetrieveDataFailed(error) =>
      emit(RetreiveWeatherDataFailed(errorMessage: error));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}

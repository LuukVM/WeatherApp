import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../constants/enums.dart';
import '../../data/weather_forecast_model.dart';
import '../../data/weather_model.dart';
import '../../data/weather_repository.dart';
import 'internet_cubit.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final InternetCubit internetCubit;
  final WeatherModel location;
  late StreamSubscription internetStreamSubscription;
  WeatherRepository _weatherRepository = WeatherRepository();

  ForecastCubit({required this.internetCubit, required this.location})
      : super(LoadingForecastData()) {
    _getForecastData();
  }

  _getForecastData() {
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
    emit(LoadingForecastData());
    List<WeatherForecastModel> forecasts =
        await _weatherRepository.getWeatherForecast(location.locationName);
    emit(RetreiveForecastDataSucces(forecasts: forecasts));
  }

  void emitRetrieveDataFailed(error) =>
      emit(RetreiveForecastDataFailed(errorMessage: error));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}

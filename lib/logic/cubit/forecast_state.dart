part of 'forecast_cubit.dart';

abstract class ForecastState {}

class LoadingForecastData extends ForecastState {}

class RetreiveForecastDataSucces extends ForecastState {
  final List<WeatherForecastModel> forecasts;

  RetreiveForecastDataSucces({required this.forecasts});
}

class RetreiveForecastDataFailed extends ForecastState {
  final String errorMessage;

  RetreiveForecastDataFailed({required this.errorMessage});
}

// enum ForecastStatus { loading, succes, failure }

// class ForecastState extends Equatable {
//   ForecastState._({
//     this.status = ForecastStatus.loading,
//     this.forecasts = const [],
//     this.errorMessage,
//   });

//   ForecastState.loading() : this._();

//   ForecastState.succes(List<WeatherForecastModel> forecasts)
//       : this._(status: ForecastStatus.succes, forecasts: forecasts);

//   ForecastState.failure(String errorMessage)
//       : this._(status: ForecastStatus.failure, errorMessage: errorMessage);

//   final ForecastStatus status;
//   final List<WeatherForecastModel> forecasts;
//   final String? errorMessage;

//   @override
//   List<Object> get props => [status, forecasts];

//   ForecastState copyWith({
//     ForecastStatus? status,
//     List<WeatherForecastModel>? forecasts,
//   }) {
//     return ForecastState.succes(
//       forecasts ?? this.forecasts,
//     );
//   }
// }

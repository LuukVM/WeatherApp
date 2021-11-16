import '../../constants/weather_icons_icons.dart';
import '../../data/weather_forecast_model.dart';
import 'condition_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key? key, required this.forecast}) : super(key: key);

  final WeatherForecastModel forecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('kk:mm').format(forecast.time),
          ),
          SizedBox(
            height: 10,
          ),
          ConditionIcon(iconId: forecast.iconId),
          Text(
            forecast.probability != 0 ? '${forecast.probability}%' : '',
          ),
          Text('${forecast.temperature}°C'),
          Divider(thickness: 1.0,),
          Icon(WeatherIcons.wind),
          Text('${forecast.windSpeed}km/h'),
        ],
      ),
    );
  }
}

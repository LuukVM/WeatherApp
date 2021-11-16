import '../../constants/weather_icons_icons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConditionIcon extends StatelessWidget {
  final String iconId;
  double? size;
  Color? color;

  ConditionIcon({required this.iconId, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(iconTheme(iconId), size: size, color: color);
  }

  IconData iconTheme(String id) {
    id = id.substring(0, 2);
    switch (id) {
      case '01':
        return WeatherIcons.sun;
      case '02':
        return WeatherIcons.cloud_sun;
      case '03':
      case '04':
        return WeatherIcons.cloud;
      case '09':
        return WeatherIcons.cloud_showers_heavy;
      case '10':
        return WeatherIcons.cloud_sun_rain;
      case '11':
        return WeatherIcons.cloud_flash_inv;
      case '13':
        return WeatherIcons.snow_inv;
      case '50':
        return Icons.menu_sharp;
      default:
        return WeatherIcons.sun;
    }
  }
}

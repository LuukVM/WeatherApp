import '../../logic/cubit/forecast_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';
import '../../logic/cubit/weather_list_cubit.dart';
import '../screens/weather_detail_screen.dart';
import 'condition_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/weather_model.dart';
import 'package:flutter/material.dart';

class WeatherOverviewCard extends StatelessWidget {
  const WeatherOverviewCard({
    Key? key,
    required this.location,
    required this.add,
  }) : super(key: key);

  final WeatherModel location;
  final bool add;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: ConditionIcon(
            iconId: location.iconId,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          location.locationName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(location.main),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              location.temperature.toString() + "°C",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            add
                ? IconButton(
                    color: Colors.green,
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 30,
                    ),
                    onPressed: () {
                      BlocProvider.of<WeatherListCubit>(context)
                          .addWeatherLocation(location);
                      Navigator.of(context).pop();
                    })
                : Text(''),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ForecastCubit(
                  internetCubit: BlocProvider.of<InternetCubit>(context),
                  location: location),
              child: WeatherDetailScreen(location: location),
            ),
          ),
        ),
      ),
    );
  }
}

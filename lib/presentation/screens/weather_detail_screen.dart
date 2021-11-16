import '../../logic/cubit/forecast_cubit.dart';
import '../../logic/cubit/weather_list_cubit.dart';
import '../widgets/condition_icons.dart';
import '../widgets/forecast_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/weather_model.dart';

import 'package:flutter/material.dart';

class WeatherDetailScreen extends StatefulWidget {
  final WeatherModel location;

  WeatherDetailScreen({Key? key, required this.location}) : super(key: key);

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  bool isInList(location) {
    return !BlocProvider.of<WeatherListCubit>(context)
        .state
        .selectedLocations
        .contains(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.location.locationName,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          isInList(widget.location)
              ? IconButton(
                  color: Colors.green,
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<WeatherListCubit>(context)
                        .addWeatherLocation(widget.location);
                    setState(() {});
                  })
              : IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<WeatherListCubit>(context)
                        .deleteWeatherLocation(widget.location);
                    setState(() {});
                  }),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Table(
                  border: TableBorder(
                    verticalInside: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3.0,
                    ),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.location.main,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                widget.location.description,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        ConditionIcon(
                          iconId: widget.location.iconId,
                          size: 50,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.bottom,
                          child: Center(
                            child: Text(
                              "${widget.location.temperature}°C",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Feels like:',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  "${widget.location.feelsLike}°C",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Table(
                  border: TableBorder(
                      verticalInside: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3.0,
                          style: BorderStyle.solid)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rain:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.rain}mm/h",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Humidity:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.humidity}%",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Snow:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.snow}mm/h",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wind speed:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.windSpeed}km/h",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Wind degree:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.windDegree}°",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Clouds:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "${widget.location.clouds}%",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 180,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surface),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocBuilder<ForecastCubit, ForecastState>(
                    builder: (context, state) {
                      if (state is LoadingForecastData) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is RetreiveForecastDataFailed) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      } else if (state is RetreiveForecastDataSucces) {
                        return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, i) {
                            return VerticalDivider(
                              thickness: 2.5,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: state.forecasts.length,
                          itemBuilder: (context, i) {
                            return ForecastWidget(
                              forecast: state.forecasts[i],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

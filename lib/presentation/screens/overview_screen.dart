import '../../logic/bloc/search_bloc.dart';
import '../../logic/cubit/internet_cubit.dart';
import '../../logic/cubit/weather_data_cubit.dart';
import '../widgets/weather_overview_card.dart';

import 'search_screen.dart';

import '../../logic/cubit/weather_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  void initState() {
    BlocProvider.of<WeatherListCubit>(context).updateLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () =>
                BlocProvider.of<WeatherListCubit>(context).updateLocations(),
          )
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WeatherDataCubit(
                      internetCubit: BlocProvider.of<InternetCubit>(context),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => SearchBloc(
                      allLocations: [],
                    ),
                  ),
                ],
                child: SearchScreen(),
              ),
            ),
          ),
        );
      }),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: BlocBuilder<WeatherListCubit, WeatherListState>(
          builder: (context, state) {
            if (state.selectedLocations.isEmpty) {
              return Center(
                child: Text(
                  'No area\'s added',
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            } else {
              return Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: ReorderableListView.builder(
                  itemCount: state.selectedLocations.length,
                  onReorder: (oldIndex, newIndex) {
                    BlocProvider.of<WeatherListCubit>(context)
                        .updateLocationsIndex(oldIndex, newIndex);
                  },
                  itemBuilder: (context, i) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                      color: Colors.transparent,
                      key: ValueKey(state.selectedLocations[i]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Dismissible(
                          key: ValueKey(state.selectedLocations[i]),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child: Icon(
                              Icons.remove_circle_outline_outlined,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            BlocProvider.of<WeatherListCubit>(context)
                                .deleteWeatherLocation(
                                    state.selectedLocations[i]);
                          },
                          direction: DismissDirection.endToStart,
                          child: WeatherOverviewCard(
                            location: state.selectedLocations[i],
                            add: false,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

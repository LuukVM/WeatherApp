import '../../logic/cubit/weather_data_cubit.dart';
import '../../logic/cubit/weather_list_cubit.dart';
import '../widgets/weather_overview_card.dart';

import '../../logic/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherDataCubit, WeatherDataState>(
      listener: (context, state) {
        if (state is RetreiveWeatherDataSucces) {
          setState(() {
            hasInternet = true;
            loading = false;
          });
          BlocProvider.of<SearchBloc>(context)
              .add(CreatedEvent(allLocations: state.allLocations));
        } else if (state is RetreiveWeatherDataFailed) {
          setState(() => hasInternet = false);
          BlocProvider.of<SearchBloc>(context)
              .add(InternetChangedEvent(errorMessage: state.errorMessage));
        } else if (state is LoadingWeatherData) {
          setState(() => loading = true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Builder(builder: (context) {
                return Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: hasInternet,
                      hintText: 'Search...',
                      suffixIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    onChanged: (change) => BlocProvider.of<SearchBloc>(context)
                        .add(QueryChangedEvent(query: change)),
                  ),
                );
              }),
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Builder(builder: (context) {
            return BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchFailed) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (state is Searching || loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchCompleted) {
                  return ListView.builder(
                    itemCount: state.foundLocations.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 8.0),
                        child: WeatherOverviewCard(
                          location: state.foundLocations[i],
                          add: isInList(state.foundLocations[i]),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            );
          }),
        ),
      ),
    );
  }

  bool isInList(location) {
    return !BlocProvider.of<WeatherListCubit>(context)
        .state
        .selectedLocations
        .contains(location);
  }
}

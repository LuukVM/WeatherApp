import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubit/weather_list_cubit.dart';

import 'constants/theme_data.dart';
import 'logic/cubit/internet_cubit.dart';
import 'presentation/screens/overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({Key? key, required this.connectivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<WeatherListCubit>(
          create: (context) => WeatherListCubit(
              internetCubit: BlocProvider.of<InternetCubit>(context)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: WeatherAppTheme.themeData,
        home: OverviewScreen(),
      ),
    );
  }
}

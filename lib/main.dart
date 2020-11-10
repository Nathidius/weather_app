import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/api/weather_service.dart';
import 'package:weather_app/cubit/settings/settings_cubit.dart';
import 'package:weather_app/cubit/weather/weather_cubit.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (_) => WeatherCubit(WeatherService())..fetchWeather(),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.blue,
        canvasColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Weather App',
      home: HomeScreen(),
    );
  }
}

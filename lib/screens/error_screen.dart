import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather/weather_cubit.dart';
import 'package:weather_app/utils/dimensions.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Something went wrong ;(',
            style: TextStyle(
              color: Colors.red,
              fontSize: FontSizes.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          FlatButton(
            onPressed: () => context.read<WeatherCubit>().fetchWeather(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/cubit/weather/weather_cubit.dart';

import 'mocks/mock_weather_service.dart';
import 'utils/constants.dart';

void main() {
  group('WeatherCubit test', () {
    blocTest('WeatherCubit fetchWeather success',
        build: () => WeatherCubit(
              mockWeatherService(weatherModel: Constants.weatherModel),
            ),
        act: (WeatherCubit cubit) {
          cubit.fetchWeather();
        },
        expect: [
          WeatherLoading(),
          WeatherLoaded(Constants.weatherModel),
        ]);

    blocTest('WeatherCubit fetchWeather failure',
        build: () => WeatherCubit(
              mockWeatherService(exception: Exception()),
            ),
        act: (WeatherCubit cubit) {
          cubit.fetchWeather();
        },
        expect: [
          WeatherLoading(),
          WeatherError(),
        ]);

    blocTest('WeatherCubit refreshWeather success',
        build: () => WeatherCubit(
              mockWeatherService(weatherModel: Constants.weatherModel),
            ),
        act: (WeatherCubit cubit) {
          cubit.refreshWeather();
        },
        expect: [
          WeatherLoaded(Constants.weatherModel),
        ]);

    blocTest('WeatherCubit refreshWeather failure',
        build: () => WeatherCubit(
              mockWeatherService(exception: Exception()),
            ),
        act: (WeatherCubit cubit) {
          cubit.refreshWeather();
        },
        expect: [
          WeatherError(),
        ]);
  });
}

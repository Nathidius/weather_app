import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/cubit/weather/weather_cubit.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utils/widgets/weather_list_item.dart';

import 'mocks/mock_settings_cubit.dart';
import 'utils/constants.dart';
import 'utils/mock_http.dart';
import 'utils/test_helpers.dart';

class MockWeatherCubit extends Mock implements WeatherCubit {}

void main() {
  group('HomeScreen test', () {
    WeatherCubit weatherCubit;

    setUp(() {
      weatherCubit = MockWeatherCubit();
      when(weatherCubit.state).thenReturn(WeatherLoading());
    });

    testWidgets('HomeScreen loading', (tester) async {
      await tester.pumpWidget(testWidget(
        HomeScreen(),
        providers: [
          BlocProvider<WeatherCubit>(create: (_) => weatherCubit),
          mockSettingsProvider(),
        ],
      ));

      final Finder finder = find.byWidgetPredicate(
        (widget) => widget is CircularProgressIndicator,
      );
      expect(finder, findsOneWidget);
    });

    testWidgets('HomeScreen error', (tester) async {
      when(weatherCubit.state).thenReturn(WeatherError());
      await tester.pumpWidget(testWidget(
        HomeScreen(),
        providers: [
          BlocProvider<WeatherCubit>(create: (_) => weatherCubit),
          mockSettingsProvider(),
        ],
      ));

      expect(find.text('Something went wrong ;('), findsOneWidget);
    });

    testWidgets('HomeScreen success', (tester) async {
      mockHttp(() async {
        when(weatherCubit.state)
            .thenReturn(WeatherLoaded(Constants.weatherModel));
        await tester.pumpWidget(testWidget(
          HomeScreen(),
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => weatherCubit),
            mockSettingsProvider(),
          ],
        ));
        expect(
          find.text(Constants.consolidatedWeather1.weatherStateName),
          findsOneWidget,
        );
      });
    });

    testWidgets('HomeScreen change day', (tester) async {
      mockHttp(() async {
        when(weatherCubit.state)
            .thenReturn(WeatherLoaded(Constants.weatherModel));
        await tester.pumpWidget(testWidget(
          HomeScreen(),
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => weatherCubit),
            mockSettingsProvider(),
          ],
        ));

        final Finder finder =
            find.byWidgetPredicate((widget) => widget is WeatherListItem);

        expect(
          find.text(Constants.consolidatedWeather1.weatherStateName),
          findsOneWidget,
        );
        expect(finder, findsNWidgets(2));

        await tester.tap(finder.last);
        await tester.pump();

        expect(
          find.text(Constants.consolidatedWeather2.weatherStateName),
          findsOneWidget,
        );
      });
    });
  });
}

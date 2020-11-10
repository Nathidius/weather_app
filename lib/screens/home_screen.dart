import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/cubit/settings/settings_cubit.dart';
import 'package:weather_app/cubit/weather/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/error_screen.dart';
import 'package:weather_app/utils/dimensions.dart';
import 'package:weather_app/utils/widgets/weather_description_widget.dart';
import 'package:weather_app/utils/widgets/weather_list.dart';
import 'package:weather_app/utils/widgets/weather_main_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return DropdownButton(
                value: state.unit,
                items: const [
                  DropdownMenuItem(
                    child: Text('°C'),
                    value: Unit.celsius,
                  ),
                  DropdownMenuItem(
                    child: Text('°F'),
                    value: Unit.fahrenheit,
                  ),
                ],
                onChanged: (unit) =>
                    context.read<SettingsCubit>().onUnitChanged(unit),
                iconEnabledColor: Colors.white,
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherError) return ErrorScreen();
            if (state is WeatherLoaded) {
              return HomeScreenContent(state.weatherModel.consolidatedWeather);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreenContent extends HookWidget {
  const HomeScreenContent(this.consolidatedWeatherList);

  final List<ConsolidatedWeather> consolidatedWeatherList;

  @override
  Widget build(BuildContext context) {
    final selectedDayIndex = useState(0);
    return LayoutBuilder(
      builder: (_, constraints) {
        return RefreshIndicator(
          color: Colors.white,
          onRefresh: () async =>
              await context.read<WeatherCubit>().refreshWeather(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.medium),
                child: OrientationBuilder(
                  builder: (_, orientation) {
                    return orientation == Orientation.portrait
                        ? _portraitHomeContent(selectedDayIndex)
                        : _landscapeHomeContent(selectedDayIndex);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _portraitHomeContent(ValueNotifier selectedDayIndex) => Column(
        children: [
          WeatherMainWidget(
            consolidatedWeather:
                consolidatedWeatherList[selectedDayIndex.value],
          ),
          WeatherDescriptionWidget(
            consolidatedWeather:
                consolidatedWeatherList[selectedDayIndex.value],
          ),
          WeatherList(
            consolidatedWeatherList: consolidatedWeatherList,
            onTap: (int index) => selectedDayIndex.value = index,
          ),
        ],
      );

  Widget _landscapeHomeContent(ValueNotifier selectedDayIndex) => Row(
        children: [
          WeatherMainWidget(
            consolidatedWeather:
                consolidatedWeatherList[selectedDayIndex.value],
          ),
          Expanded(
            child: WeatherDescriptionWidget(
              consolidatedWeather:
                  consolidatedWeatherList[selectedDayIndex.value],
            ),
          ),
          WeatherList(
            consolidatedWeatherList: consolidatedWeatherList,
            onTap: (int index) => selectedDayIndex.value = index,
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/settings/settings_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/dimensions.dart';
import 'package:weather_app/utils/extensions/double_extensions.dart';

import 'description_text.dart';

class WeatherDescriptionWidget extends StatelessWidget {
  const WeatherDescriptionWidget({
    @required this.consolidatedWeather,
  });

  final ConsolidatedWeather consolidatedWeather;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: Column(
        key: Key(consolidatedWeather.weatherStateName),
        crossAxisAlignment:
            isPortrait ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final temp = state.unit == Unit.celsius
                    ? consolidatedWeather.theTemp
                    : consolidatedWeather.theTemp.toFarenheit();
                return AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: Text(
                    '${temp.toInt()}°',
                    key: Key('${temp.toInt()}'),
                    style: const TextStyle(
                      fontSize: FontSizes.extraLarge,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
          ),
          DescriptionText('Humidity: ${consolidatedWeather.humidity}%'),
          DescriptionText(
            'Pressure: ${consolidatedWeather.airPressure.toInt()} hPA',
          ),
          DescriptionText(
            'Wind: ${(consolidatedWeather.windSpeed * 1.61).toInt()} km/h',
          ),
          if (!isPortrait) ...[
            DescriptionText(
              'Wind direction: ${consolidatedWeather.windDirectionCompass}',
            ),
            DescriptionText(
              'Predictability: ${consolidatedWeather.predictability} %',
            ),
          ],
        ],
      ),
    );
  }
}

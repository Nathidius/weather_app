import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/cubit/settings/settings_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/dimensions.dart';
import 'package:weather_app/utils/extensions/datetime_extensions.dart';
import 'package:weather_app/utils/extensions/double_extensions.dart';

class WeatherListItem extends StatelessWidget {
  const WeatherListItem({
    @required this.consolidatedWeather,
    @required this.onTap,
  });

  final ConsolidatedWeather consolidatedWeather;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.weatherListItemSize,
      width: Dimensions.weatherListItemSize,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.small),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.small),
          onTap: onTap,
          hoverColor: Colors.blue,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    consolidatedWeather.applicableDate
                        .formatDateTimeToShortDay(),
                    style: const TextStyle(
                      fontSize: FontSizes.small,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SvgPicture.network(
                  consolidatedWeather.weatherStateAbbrImageUrl,
                  width: double.infinity,
                  placeholderBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      final minTemp = state.unit == Unit.celsius
                          ? consolidatedWeather.minTemp
                          : consolidatedWeather.minTemp.toFarenheit();
                      final maxTemp = state.unit == Unit.celsius
                          ? consolidatedWeather.maxTemp
                          : consolidatedWeather.maxTemp.toFarenheit();
                      return AnimatedSwitcher(
                        duration: kThemeAnimationDuration,
                        child: Text(
                          '${minTemp.toInt()}°/${maxTemp.toInt()}°',
                          key: Key('${minTemp.toInt()}°/${maxTemp.toInt()}°'),
                          style: const TextStyle(
                            fontSize: FontSizes.small,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

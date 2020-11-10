import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/dimensions.dart';
import 'package:weather_app/utils/extensions/datetime_extensions.dart';
import 'package:weather_app/utils/widgets/description_text.dart';

class WeatherMainWidget extends StatelessWidget {
  const WeatherMainWidget({
    @required this.consolidatedWeather,
  });

  final ConsolidatedWeather consolidatedWeather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: Column(
          key: Key(consolidatedWeather.weatherStateName),
          children: [
            Text(
              consolidatedWeather.applicableDate.formatDateTimeToDay(),
              style: const TextStyle(
                fontSize: FontSizes.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            DescriptionText(consolidatedWeather.weatherStateName),
            Expanded(
              child: SvgPicture.network(
                consolidatedWeather.weatherStateAbbrImageUrl,
                width: double.infinity,
                placeholderBuilder: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

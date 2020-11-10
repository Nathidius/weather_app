import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/dimensions.dart';
import 'package:weather_app/utils/widgets/weather_list_item.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({
    @required this.consolidatedWeatherList,
    @required this.onTap,
  });

  final List<ConsolidatedWeather> consolidatedWeatherList;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      height: isPortrait ? Dimensions.weatherListItemSize : double.infinity,
      width: isPortrait ? double.infinity : Dimensions.weatherListItemSize,
      child: ListView.builder(
        scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
        itemCount: consolidatedWeatherList.length,
        itemBuilder: (_, index) => WeatherListItem(
          consolidatedWeather: consolidatedWeatherList[index],
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}

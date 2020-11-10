import 'package:weather_app/models/weather_model.dart';

abstract class Constants {
  Constants._();

  static final consolidatedWeather1 = ConsolidatedWeather(
    weatherStateName: 'Heavy Rain',
    weatherStateAbbr: 'hr',
    windDirectionCompass: 'SW',
    applicableDate: DateTime.now(),
    minTemp: 9.58,
    maxTemp: 13.954999999999998,
    theTemp: 14.205,
    windSpeed: 12.53646556340306,
    windDirection: 226.33227894316346,
    airPressure: 1004.0,
    humidity: 74,
    predictability: 77,
  );

  static final consolidatedWeather2 = ConsolidatedWeather(
    weatherStateName: 'Showers',
    weatherStateAbbr: 's',
    windDirectionCompass: 'SSW',
    applicableDate: DateTime.now(),
    minTemp: 10.2,
    maxTemp: 15.315,
    theTemp: 13.754999999999999,
    windSpeed: 3.387528286476312,
    windDirection: 200.83327456293287,
    airPressure: 1023.0,
    humidity: 85,
    predictability: 73,
  );

  static final weatherModel = WeatherModel(
    consolidatedWeather: [
      consolidatedWeather1,
      consolidatedWeather2,
    ],
  );
}

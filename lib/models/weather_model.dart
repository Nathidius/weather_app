import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    this.consolidatedWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        consolidatedWeather: List<ConsolidatedWeather>.from(
            json['consolidated_weather']
                .map((x) => ConsolidatedWeather.fromJson(x))),
      );

  List<ConsolidatedWeather> consolidatedWeather;

  Map<String, dynamic> toJson() => {
        'consolidated_weather':
            List<dynamic>.from(consolidatedWeather.map((x) => x.toJson())),
      };
}

class ConsolidatedWeather {
  ConsolidatedWeather({
    this.weatherStateName,
    this.weatherStateAbbr,
    this.windDirectionCompass,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.windDirection,
    this.airPressure,
    this.humidity,
    this.predictability,
  });

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      ConsolidatedWeather(
        weatherStateName: json['weather_state_name'],
        weatherStateAbbr: json['weather_state_abbr'],
        windDirectionCompass: json['wind_direction_compass'],
        applicableDate: DateTime.parse(json['applicable_date']),
        minTemp: json['min_temp'].toDouble(),
        maxTemp: json['max_temp'].toDouble(),
        theTemp: json['the_temp'].toDouble(),
        windSpeed: json['wind_speed'].toDouble(),
        windDirection: json['wind_direction'].toDouble(),
        airPressure: json['air_pressure'],
        humidity: json['humidity'],
        predictability: json['predictability'],
      );

  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  int predictability;

  Map<String, dynamic> toJson() => {
        'weather_state_name': weatherStateName,
        'weather_state_abbr': weatherStateAbbr,
        'wind_direction_compass': windDirectionCompass,
        'applicable_date':
            "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
        'min_temp': minTemp,
        'max_temp': maxTemp,
        'the_temp': theTemp,
        'wind_speed': windSpeed,
        'wind_direction': windDirection,
        'air_pressure': airPressure,
        'humidity': humidity,
        'predictability': predictability,
      };

  String get weatherStateAbbrImageUrl =>
      'https://www.metaweather.com/static/img/weather/$weatherStateAbbr.svg';
}

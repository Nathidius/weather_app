import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherModel();
}

class WeatherService implements WeatherRepository {
  static const _baseUrl = 'www.metaweather.com';
  static const _london = '/api/location/44418';

  @override
  Future<WeatherModel> getWeatherModel() async {
    final Uri uri = Uri.https(_baseUrl, _london);
    final http.Response response = await http.get(uri);
    final WeatherModel weather = weatherModelFromJson(response.body);
    return weather;
  }
}

import 'package:mockito/mockito.dart';
import 'package:weather_app/api/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class MockWeatherService extends Mock implements WeatherService {}

MockWeatherService mockWeatherService({
  WeatherModel weatherModel,
  Exception exception,
}) {
  final mockWeatherService = MockWeatherService();

  if (exception != null) {
    when(mockWeatherService.getWeatherModel()).thenThrow(exception);
  } else {
    when(mockWeatherService.getWeatherModel()).thenAnswer(
      (_) async => weatherModel ?? WeatherModel(consolidatedWeather: []),
    );
  }

  return mockWeatherService;
}

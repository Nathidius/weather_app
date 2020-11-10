part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.weatherModel);

  final WeatherModel weatherModel;

  @override
  List<Object> get props => [weatherModel];
}

class WeatherError extends WeatherState {
  @override
  List<Object> get props => [];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../api/weather_service.dart';
import '../../models/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherRepository) : super(WeatherLoading());

  final WeatherRepository weatherRepository;

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    try {
      final weatherModel = await weatherRepository.getWeatherModel();
      emit(WeatherLoaded(weatherModel));
    } catch (e) {
      emit(WeatherError());
    }
  }

  Future<void> refreshWeather() async {
    try {
      final weatherModel = await weatherRepository.getWeatherModel();
      emit(WeatherLoaded(weatherModel));
    } catch (e) {
      emit(WeatherError());
    }
  }
}

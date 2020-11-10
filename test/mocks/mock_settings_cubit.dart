import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/cubit/settings/settings_cubit.dart';

class MockSettingsCubit extends Mock implements SettingsCubit {}

MockSettingsCubit mockSettingsCubit() {
  final mockSettingsCubit = MockSettingsCubit();
  when(mockSettingsCubit.state).thenReturn(const SettingsState(Unit.celsius));

  return mockSettingsCubit;
}

BlocProvider mockSettingsProvider() {
  return BlocProvider<SettingsCubit>(
    create: (_) => mockSettingsCubit(),
  );
}

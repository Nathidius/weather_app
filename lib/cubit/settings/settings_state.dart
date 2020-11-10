part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState(this.unit);

  final Unit unit;

  @override
  List<Object> get props => [unit];
}

enum Unit { celsius, fahrenheit }

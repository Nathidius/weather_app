import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatDateTimeToShortDay() => DateFormat('E').format(this);

  String formatDateTimeToDay() => DateFormat('EEEE').format(this);
}

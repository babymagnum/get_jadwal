import 'package:intl/intl.dart';

extension StringExtension on String {
  String convertDateStringToAnotherFormat(String pattern) {
    return DateFormat(pattern, 'ID').format(DateTime.parse(this).toLocal());
  }

  String get getDayCode {
    if (this == 'Senin') {
      return 'monday';
    } else if (this == 'Selasa') {
      return 'tuesday';
    } else if (this == 'Rabu') {
      return 'wednesday';
    } else if (this == 'Kamis') {
      return 'thursday';
    } else {
      return 'friday';
    }
  }
}
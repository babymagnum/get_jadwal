import 'package:intl/intl.dart';

extension StringExtension on String {
  String convertDateStringToAnotherFormat(String pattern) {
    return DateFormat(pattern, 'ID').format(DateTime.parse(this).toLocal());
  }
}
import 'package:intl/intl.dart';

class DateHelper {
  static DateTime stringToDate(String dateString) {
    final format = DateFormat('yyyy-MM-dd');
    DateTime gettingDate = format.parse(dateString);

    return gettingDate;
  }

  static String changeDateFormat(DateTime date) {
    final format = DateFormat('dd.MM.yyyy HH:mm');

    return format.format(date);
  }
}
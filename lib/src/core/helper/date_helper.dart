// import intl for date formatting
import 'package:intl/intl.dart';

class DateHelper {
  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String getFormattedDateWithTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String getFormattedTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  // 03rd Jan 2021
  static String getFormattedDateWithOrdinal(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}

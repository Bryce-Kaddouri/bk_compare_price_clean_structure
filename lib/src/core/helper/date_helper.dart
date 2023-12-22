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

  static getNbDaysForYear(int year) {
    return DateTime(year, 12, 31).difference(DateTime(year, 1, 1)).inDays;
  }

  // get a list of number that correspond of each first day of the month (ex: 1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335)
  static List<int> getFirstDayOfMonth(int year) {
    List<int> firstDayOfMonth = [];
    for (int i = 1; i <= 12; i++) {
      firstDayOfMonth.add(
          DateTime(year, i, 1).difference(DateTime(year, 1, 1)).inDays + 1);
    }
    return firstDayOfMonth;
  }

  // method to get the day number in a year for a given date
  static int getDayNumberInYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  }

  static String getMonthName(int day, int year) {
    DateTime date = DateTime(year, 1, 1).add(Duration(days: day - 1));
    return DateFormat('MMM').format(date);
  }
}

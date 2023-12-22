import 'package:bk_compare_price_mvc/src/core/helper/date_helper.dart';
import 'package:flutter/material.dart';

class LineChartProvider with ChangeNotifier {
  int _selectedMonth = DateTime.now().month;

  int get selectedMonth => _selectedMonth;

  void setSelectedMonth(int month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void resetSelectedMonth() {
    _selectedMonth = DateTime.now().month;
    notifyListeners();
  }

  int _selectedYear = DateTime.now().year;

  int get selectedYear => _selectedYear;

  void setSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void resetSelectedYear() {
    _selectedYear = DateTime.now().year;
    notifyListeners();
  }

  int _numberOfDaysInSelectedYear = DateTime.now().year % 4 == 0 ? 366 : 365;

  int get numberOfDaysInSelectedYear => _numberOfDaysInSelectedYear;

  void setNumberOfDaysInSelectedYear(int numberOfDays) {
    _numberOfDaysInSelectedYear = numberOfDays;
    notifyListeners();
  }

  List<int> _firstDayOfMonth =
      DateHelper.getFirstDayOfMonth(DateTime.now().year);

  List<int> get firstDayOfMonth => _firstDayOfMonth;

  void setFirstDayOfMonth(int year) {
    _firstDayOfMonth = DateHelper.getFirstDayOfMonth(year);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

enum NavigationPages { products, calendar, home, about, settings }

class NavigationBarController extends ChangeNotifier {
  int pageIndex = NavigationPages.home.index;

  NavigationPages get page => NavigationPages.values[pageIndex];

  void setPageIndex(int i) {
    pageIndex = i;
    notifyListeners();
  }

  void setPageIndexToCalendar() {
    pageIndex = NavigationPages.calendar.index;
    notifyListeners();
  }
}

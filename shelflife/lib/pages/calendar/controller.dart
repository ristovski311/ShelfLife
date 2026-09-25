// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelflife/classes/database/category_rep.dart';
import 'package:shelflife/classes/database/expiration_rep.dart';
import 'package:shelflife/classes/mock/expiration.dart';
import 'package:shelflife/classes/models/category.dart';
import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/config/notifications.dart';
import 'package:shelflife/config/toast.dart';
import 'package:shelflife/main.dart';

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}

enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

final Map<Month, Color> monthColors = {
  Month.January: Colors.lightBlue,
  Month.February: Colors.lightBlue,
  Month.March: Colors.green,
  Month.April: Colors.green,
  Month.May: Colors.green,
  Month.June: Colors.amber,
  Month.July: Colors.amber,
  Month.August: Colors.amber,
  Month.September: Colors.deepOrange,
  Month.October: Colors.deepOrange,
  Month.November: Colors.deepOrange,
  Month.December: Colors.lightBlue,
};

class CalendarController extends ChangeNotifier {
  final _expirationRepo = ExpirationRep();
  final _categoryRepo = CategoryRep();
  late SharedPreferences _prefs;

  bool isGoingForward = true;

  int selectedYear = DateTime.now().year;
  Month selectedMonth = Month.values[DateTime.now().month - 1];
  List<Expiration> expirationsForSelectedMonth = [];
  List<Category> categoryList = [];

  Future<void> setup() async {
    await _refresh();
    await _loadCategories();
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    categoryList = await _categoryRepo.getAll();
  }

  Future<void> _refresh() async {
    expirationsForSelectedMonth = await _expirationRepo
        .getShouldRemindThisYearAndMonth(selectedYear, selectedMonth.index + 1);

    notifyListeners();
  }

  Future<void> refreshCategories() => _loadCategories();

  List<Expiration> getExpirationsForGivenDay(
    int day, {
    int remindDaysInAdvance = 15,
  }) {
    return expirationsForSelectedMonth
        .where(
          (e) =>
              (e.expirationDate
                  .subtract(Duration(days: remindDaysInAdvance))
                  .day ==
              day),
        )
        .toList();
  }

  bool isTodaySelected() {
    return (selectedYear == DateTime.now().year &&
        selectedMonth == Month.values[DateTime.now().month - 1]);
  }

  String getWeekOfTheDay(int day) {
    return Days
        .values[DateTime(selectedYear, selectedMonth.index + 1, day).weekday -
            1]
        .name;
  }

  void setToToday() {
    int curYear = DateTime.now().year;
    Month curMonth = Month.values[DateTime.now().month - 1];

    if (curYear < selectedYear) {
      isGoingForward = false;
    } else if (curYear > selectedYear) {
      isGoingForward = true;
    } else if (curMonth.index < selectedMonth.index) {
      isGoingForward = false;
    } else {
      isGoingForward = true;
    }

    selectedYear = DateTime.now().year;
    selectedMonth = Month.values[DateTime.now().month - 1];

    _refresh();
  }

  void changeMonth(bool previous) {
    isGoingForward = !previous;
    selectedMonth = previous
        ? Month.values[(selectedMonth.index - 1) % 12]
        : Month.values[(selectedMonth.index + 1) % 12];
    if (selectedMonth == Month.December && previous) {
      selectedYear = selectedYear - 1;
    } else if (selectedMonth == Month.January && !previous) {
      selectedYear = selectedYear + 1;
    }

    _refresh();
  }

  Color getCurrentMonthColor() {
    return monthColors[selectedMonth] ?? Colors.pink;
  }

  int getSelectedMonthDuration() {
    int monthIndex = selectedMonth.index + 1;
    return DateTime(selectedYear, monthIndex + 1, 0).day;
  }

  bool isDateToday(int day) {
    return (DateTime.now().year == selectedYear &&
        DateTime.now().month == (selectedMonth.index + 1) &&
        DateTime.now().day == day);
  }

  //
  //Creation form
  //

  final expirationProductBrandController = TextEditingController(text: "");
  final expirationProductNameController = TextEditingController(text: "");
  final expirationDayController = TextEditingController();
  final expirationMonthController = TextEditingController();
  final expirationYearController = TextEditingController();
  int expirationProductCategoryId = 0;

  void addExpiration() {
    String productBrand = expirationProductBrandController.text;
    String productName = expirationProductNameController.text;
    int productCategoryId = expirationProductCategoryId;

    int expirationDay = int.tryParse(expirationDayController.text) ?? 1;
    int expirationMonth = int.tryParse(expirationMonthController.text) ?? 1;
    int expirationYear = int.tryParse(expirationYearController.text) ?? 2000;

    DateTime expirationDate = DateTime(
      expirationYear,
      expirationMonth,
      expirationDay,
    );

    var e = Expiration(
      id: mockExpirations.length,
      productBrand: productBrand,
      productName: productName,
      categoryId: productCategoryId,
      createdAt: DateTime.now(),
      noted: false,
      expirationDate: expirationDate,
    );

    try {
      if (productBrand.isNotEmpty && productName.isNotEmpty) {
        _expirationRepo.insert(e);
      }

      final reminderHour = _prefs.getInt('reminder_hour') ?? 10;
      final reminderMinute = _prefs.getInt('reminder_minute') ?? 0;
      NotificationService.instance.scheduleExpirationAlarm(
        e,
        reminderHour,
        reminderMinute,
      );

      ToastService.instance.success(
        "${"Successfully created expiration for".tr} $productBrand $productName",
      );
    } catch (e) {
      ToastService.instance.error("${"An error has occurred".tr}!");
    } finally {
      _refresh();
      expirationProductBrandController.text = "";
      expirationProductNameController.text = "";
      expirationDayController.text = "";
      expirationMonthController.text = "";
      expirationYearController.text = "";
    }
  }

  //
  // Expiration confirmation
  //

  Future<void> noteExpirationByIdCalendar(int id, {bool noted = true}) async {
    try {
      await _expirationRepo.setNoted(id, noted);
      NotificationService.instance.cancelAlarm(id);
      ToastService.instance.success("${"Expiration noted successfully".tr}.");
    } catch (e) {
      ToastService.instance.error("${"An error has occurred".tr}.");
    } finally {
      _refresh();
    }
  }

  Future<void> deleteExpirationCalendar(int id) async {
    try {
      await _expirationRepo.delete(id);
      NotificationService.instance.cancelAlarm(id);
      ToastService.instance.success("${"Expiration deleted successfully".tr}.");
    } catch (e) {
      ToastService.instance.error("${"An error has occurred".tr}.");
    } finally {
      _refresh();
    }
  }
}

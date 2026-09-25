import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelflife/classes/database/expiration_rep.dart';
import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/config/notifications.dart';
import 'package:shelflife/config/toast.dart';
import 'package:shelflife/config/translation.dart';
import 'package:shelflife/main.dart';

class SettingsController extends ChangeNotifier {
  String selectedLanguage = TranslationService.instance.currentLocale;
  late SharedPreferences prefs;
  int reminderHour = 10;
  int reminderMinute = 0;

  Future<void> setup() async {
    prefs = await SharedPreferences.getInstance();
    reminderHour = prefs.getInt("reminder_hour") ?? 10;
    reminderMinute = prefs.getInt("reminder_minute") ?? 0;
    notifyListeners();
  }

  final Map<String, Map<String, String>> languages = {
    'sr': {'name': 'Serbian', 'flag': '🇷🇸'},
    'en': {'name': 'English', 'flag': '🇬🇧'},
  };

  void selectLanguage(String code) async {
    selectedLanguage = code;
    await TranslationService.instance.load(code);
  }

  Future<void> resetAlarmsForExpirations() async {
    final expirationRepo = ExpirationRep();
    List<Expiration> allExpirations = await expirationRepo.getAll();

    int failed = 0;
    for (var e in allExpirations) {
      try {
        await NotificationService.instance.cancelAlarm(e.id);
        await NotificationService.instance.scheduleExpirationAlarm(
          e,
          reminderHour,
          reminderMinute,
        );
      } catch (err) {
        failed++;
      }
    }

    if (failed == 0) {
      ToastService.instance.info(
        "${"Reminders for all expirations have been reset".tr}.",
      );
    } else {
      ToastService.instance.failure(
        "${"Reset finished with errors for".tr} $failed ${"items".tr}",
      );
    }
  }

  //
  //Form for reminder time change
  //

  final hoursController = TextEditingController(text: "");
  final minutesController = TextEditingController(text: "");

  void changeAlarmTime() {
    reminderHour = int.tryParse(hoursController.text) ?? reminderHour;
    reminderMinute = int.tryParse(minutesController.text) ?? reminderMinute;

    prefs.setInt('reminder_hour', reminderHour);
    prefs.setInt('reminder_minute', reminderMinute);

    ToastService.instance.info(
      "${"Alarm reminder time changed to".tr} $reminderHour:$reminderMinute",
    );

    hoursController.text = "";
    minutesController.text = "";

    resetAlarmsForExpirations();
    notifyListeners();
  }
}

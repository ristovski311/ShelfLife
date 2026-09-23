import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService extends ChangeNotifier {
  TranslationService._internal();
  static final TranslationService instance = TranslationService._internal();

  String _currentLocale = 'en';
  Map<String, String> _localizedValues = {};

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString("selected_locale") ?? 'en';
    await load(savedLocale);
  }

  String get currentLocale => _currentLocale;

  Future<void> load(String locale) async {
    _currentLocale = locale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selected_locale", locale);

    final jsonString = await rootBundle.loadString(
      'assets/translations/$locale.json',
    );

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedValues = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    notifyListeners();
  }

  String translate(String key) {
    return _localizedValues[key] ?? key;
  }
}

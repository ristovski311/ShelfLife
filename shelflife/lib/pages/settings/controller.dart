import 'package:flutter/material.dart';
import 'package:shelflife/config/translation.dart';

class SettingsController extends ChangeNotifier {
  String selectedLanguage = TranslationService.instance.currentLocale;

  final Map<String, Map<String, String>> languages = {
    'sr': {'name': 'Serbian', 'flag': '🇷🇸'},
    'en': {'name': 'English', 'flag': '🇬🇧'},
  };

  void selectLanguage(String code) async {
    selectedLanguage = code;
    await TranslationService.instance.load(code);
  }
}

import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode mode = ThemeMode.light;

  void setNewLang(String newLang) {
    if(appLanguage == newLang) return;
    appLanguage = newLang;
    notifyListeners();
  }

  void setNewMode(ThemeMode newMode) {
    if(mode == newMode) return;
    mode = newMode;
    notifyListeners();
  }
}
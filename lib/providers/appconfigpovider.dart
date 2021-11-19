import 'package:flutter/material.dart';
import 'package:todo_app/userpreferences.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode mode = ThemeMode.light;

  AppConfigProvider() {
    if(UserPreferences.getUserLang() == 'ar') {
      appLanguage = 'ar';
    } else {
      appLanguage = 'en';
    }

    if(UserPreferences.getUserTheme() == 'D') {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
  }

  void setNewLang(String newLang) async {
    if(appLanguage == newLang) return;
    appLanguage = newLang;
    await UserPreferences.setUserLang(appLanguage);
    notifyListeners();
  }

  void setNewMode(ThemeMode newMode) async {
    if(mode == newMode) return;
    mode = newMode;
    if(mode == ThemeMode.light) {
      await UserPreferences.setUserTheme('L');
    } else {
      await UserPreferences.setUserTheme('D');
    }
    notifyListeners();
  }
}
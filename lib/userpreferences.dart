import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future setUserLang(String lang) async {
    await pref.setString('appLanguage', lang);
  }

  static String? getUserLang() {
    return pref.getString('appLanguage');
  }

  static Future setUserTheme(String mode) async {
    await pref.setString('mode', mode);
  }

  static String? getUserTheme() {
    return pref.getString('mode');
  }
}
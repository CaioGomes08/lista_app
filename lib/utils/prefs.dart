import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static void setBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static void setInt(String key, int value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<String?> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void setString(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}

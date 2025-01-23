import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html';

Future<void> saveData(String key, String value) async {
  // SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  window.localStorage[key] = value;
}

Future<void> clearData() async {
  // SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  window.localStorage.clear();
}

Future<String?> getToken(key) async {
  final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
    // return window.localStorage[key];
  // if (window.localStorage[key] != null) {
  // } else {
  // }
}
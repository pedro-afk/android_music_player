import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPref;
  AppPreferences(this._sharedPref);

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await _sharedPref.setString(key, jsonEncode(value));
  }

  Future<Map<String, dynamic>> getMap(String key) async {
    return jsonDecode(_sharedPref.getString(key) ?? "{}");
  }
}

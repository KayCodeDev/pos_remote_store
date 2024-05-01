import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences>? _prefs;

  static Future<SharedPreferences>? _getInstance() {
    _prefs ??= SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> remove(String key) async {
    return (await _getInstance()!).remove(key);
  }

  static Future<bool> exist(String key) async {
    return (await _getInstance()!).containsKey(key);
  }

  static Future<String> getString(String key, {String fb = ''}) async {
    return (await _getInstance()!).getString(key) ?? fb;
  }

  static Future<String> setString(String key, String value) async {
    await (await _getInstance()!).setString(key, value);
    return value;
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      final map = await getString(key);
      return map.isEmpty ? null : json.decode(map);
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> setMap(
      String key, Map<String, dynamic> value) async {
    await setString(key, json.encode(value));
    return value;
  }

  static Future<int> getInt(String key) async {
    return (await _getInstance()!).getInt(key) ?? 0;
  }

  static Future<int> setInt(String key, int value) async {
    await (await _getInstance())?.setInt(key, value);
    return value;
  }

  static Future<bool> getBool(String key, {bool value = false}) async {
    return (await _getInstance()!).getBool(key) ?? value;
  }

  static Future<bool> setBool(String key, bool value) async {
    await (await _getInstance())?.setBool(key, value);
    return value;
  }

  static Future<List> getList(String key) async {
    try {
      final list = await getString(key);
      return list.isEmpty ? [] : json.decode(list);
    } catch (e) {
      return [];
    }
  }

  static Future<List> setList(String key, List value) async {
    await setString(key, json.encode(value));
    return value;
  }
}

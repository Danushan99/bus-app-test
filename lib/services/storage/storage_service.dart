// lib/services/storage/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  // Bool
  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  // Int
  Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);

  // Remove / Clear
  Future<void> remove(String key) async => await _prefs.remove(key);
  Future<void> clear() async => await _prefs.clear();

  bool containsKey(String key) => _prefs.containsKey(key);
}

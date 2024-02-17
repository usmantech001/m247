import 'package:shared_preferences/shared_preferences.dart';

class BaseKVStorage {
  const BaseKVStorage._();

  static BaseKVStorage? _instance;

  static SharedPreferences? _preference;

  static BaseKVStorage get instance => _instance ?? const BaseKVStorage._();

  static Future<void> init() async {
    _preference ??= await SharedPreferences.getInstance();
  }

  Future<bool> contain(String key) async {
    try {
      return _preference!.containsKey(key);
    } on Exception catch (e) {
      return false;
    }
  }

  T? getCommon<T>(String key) {
    try {
      switch (T) {
        case String:
          return _preference!.getString(key) as T?;
        case int:
          return _preference!.getInt(key) as T?;
        case bool:
          return _preference!.getBool(key) as T?;
        case double:
          return _preference!.getDouble(key) as T?;
        case List:
          return _preference!.getStringList(key) as T;
        default:
          return _preference!.get(key) as T?;
      }
    } on Exception {
      return null;
    }
  }

  Future<bool> setCommon<T>(String key, T value) {
    switch (T) {
      case String:
        return _preference!.setString(key, value as String);
      case int:
        return _preference!.setInt(key, value as int);
      case bool:
        return _preference!.setBool(key, value as bool);
      case double:
        return _preference!.setDouble(key, value as double);
      case List:
        return _preference!.setStringList(key, value as List<String>);
      default:
        return _preference!.setString(key, value as String);
    }
  }

  Future<bool> clearShared() async {
    try {
      await _preference!.clear();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}

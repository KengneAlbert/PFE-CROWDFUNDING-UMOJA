import 'package:hive/hive.dart';

class LocalStorageService {
  static const String _boxName = 'cachedData';

  static Future<void> saveData(String key, dynamic value) async {
    var box = await Hive.openBox(_boxName);
    await box.put(key, value);
  }

  static Future<dynamic> loadData(String key) async {
    var box = await Hive.openBox(_boxName);
    return box.get(key);
  }

  static Future<void> clearData(String key) async {
    var box = await Hive.openBox(_boxName);
    await box.delete(key);
  }
}

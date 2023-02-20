import 'package:hive/hive.dart';

class HiveService {
  static Future<List> readList({required String key}) async {
    Box<List> box = Hive.box(key);
    List data = box.get(key) ?? [];
    return data;
  }

  static writeList({
    required String key,
    required var value,
  }) async {
    Box<List> box = Hive.box<List>(key);
    List data = box.get(key) ?? [];
    data.add(value);
    box.put(key, data);
  }

  static removeList({
    required String key,
    required var value,
  }) async {
    Box<List> box = Hive.box<List>(key);
    List data = box.get(key) ?? [];
    for (var i = 0; i < data.length; i++) {
      if (data[i].id == value.id) data.removeAt(i);
    }
    box.put(key, data);
  }
}

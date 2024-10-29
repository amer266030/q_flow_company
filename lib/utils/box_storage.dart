import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class BoxStorage {
  static final box = GetStorage();

  /*    MARK: - READ    */
  // Single Item

  static Future<T?> readItem<T>({
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    String? data = box.read(key);

    if (data == null || data.isEmpty) {
      return null;
    }

    var jsonResult = json.decode(data);
    return fromJson(jsonResult);
  }

  // List of Items

  static Future<List<T>> readItems<T>({
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    String? data = box.read(key);

    if (data == null || data.isEmpty) {
      return [];
    }

    var jsonResult = json.decode(data);
    List<T> objects = (jsonResult != null)
        ? List<T>.from(jsonResult.map((jsonItem) => fromJson(jsonItem)))
        : [];
    return objects;
  }

  /*    MARK: - WRITE    */
  // Single Item

  static Future<void> writeItem<T>({
    required T item,
    required String key,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    String data = json.encode(toJson(item));
    await box.write(key, data);
  }

  // List of Items

  static Future<void> writeItems<T>({
    required List<T> items,
    required String key,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    String data = json.encode(items.map((item) => toJson(item)).toList());
    await box.write(key, data);
  }
}

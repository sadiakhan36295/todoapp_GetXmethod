import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  /// Write data to storage
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Read data from storage (returns null if key not found)
  T? read<T>(String key) {
    return _box.read(key) as T?;
  }

  /// Remove data from storage
  Future<void> remove(String key) async {
    await _box.remove(key);
  }
}

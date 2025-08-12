import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
final storageController = SecureStorageController();

class SecureStorageController {
  // write
  Future<void> write(
    String key,
    dynamic value,
  ) async {
    await storage.write(
      key: key,
      value: value.toString(),
    );
  }

  // delete
  Future<void> delete(
    String key,
  ) async {
    await storage.delete(key: key);
  }

  // get
  Future<dynamic> get(String key, {bool isInteger = false}) async {
    String? value = await storage.read(key: key);
    try {
      if (value != null && isInteger) {
        return int.parse(value);
      } else {
        return value;
      }
    } catch (e) {
      return value;
    }
  }

  // get all value
  Future<Map<String, String>> getAll() async {
    return await storage.readAll();
  }

  // clear
  Future<void> clear() async {
    await storage.deleteAll();
  }
}

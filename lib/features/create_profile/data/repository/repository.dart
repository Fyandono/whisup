import 'dart:async';
import 'dart:math';

class CreateUsernameRepository {
  final Random _random = Random();

  Future<bool> getIsUsernameTaken(String username) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // simulate loading

      // Simulate random result
      final response = _random.nextBool(); // true or false randomly

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUsernameFromDeviceId(String deviceId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // simulate loading

      return "fyandono";
    } catch (e) {
      rethrow;
    }
  }
}

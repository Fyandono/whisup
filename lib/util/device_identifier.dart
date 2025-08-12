import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

class DeviceIdentifier {
  static Future<String> getDeviceID() async {
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
      if (identifier == null) {
        throw 'No Identifier';
      }
      return identifier;
    } on PlatformException {
      throw 'No Identifier';
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:whisup/features/whisps/data/model/whisp.dart';
import 'package:whisup/util/secure_storage.dart';

class WhispsRepository {
  Future<List<CardWhispModel>> getWhisps(int currentPage, int pageSize) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      final List<CardWhispModel> response = List.generate(pageSize, (index) {
        final random = Random();
        final messages = [
          "Just saw the sunset, feeling grateful.",
          "Why do Mondays feel like boss fights?",
          "Anyone else up thinking too much?",
          "This coffee is saving my life right now ☕",
          "Can’t stop listening to this one song 🎧",
        ];
        final usernames = [
          "whispercat",
          "midnightowl",
          "anonhuman",
          "dreamer01",
          "quietstorm",
        ];
        final sampleReactions = {
          "❤️": random.nextInt(5),
          "😂": random.nextInt(5),
          "😮": random.nextInt(5),
          "🤝": random.nextInt(5),
        };

        /// Generate random avatar (7x7 grid, ~10–15 pixels filled)
        final avatar = <String, Color>{};
        final pixelCount = random.nextInt(10) + 5;

        for (int i = 0; i < pixelCount; i++) {
          final x = random.nextInt(7);
          final y = random.nextInt(7);
          final key = '${x}_$y';

          final color = Color.fromARGB(
            0xFF,
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
          );
          avatar[key] = color;
        }

        return CardWhispModel(
          id: index,
          username: usernames[random.nextInt(usernames.length)],
          message: messages[random.nextInt(messages.length)],
          createdAt:
              DateTime.now()
                  .subtract(Duration(minutes: random.nextInt(120)))
                  .toIso8601String(),
          reactions:
              sampleReactions.entries.map((e) => {e.key: e.value}).toList(),
          avatar: avatar,
          lat: 0,
          long: 0,
        );
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProfile(String deviceId) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      final pixelAvatar = await storageController.get("pixel_avatar");
      final List<dynamic> savedList = jsonDecode(pixelAvatar);
      final Map<String, Color> coloredPixels = {};
      final username = await storageController.get("username");

      for (var entry in savedList) {
        final parts = entry.split(':');
        final key = parts[0]; // e.g., "10,15"
        final argbHex = parts[1]; // e.g., "ff0000ff"

        final argb = int.parse(argbHex, radix: 16);
        coloredPixels[key] = Color(argb);
      }

      final response = {"username": username, "pixel_avatar": coloredPixels};

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

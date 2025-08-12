import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';

class CardWhispModel {
  final int id;
  final String username;
  final String message;
  final String createdAt;
  final List<Map<String, int>> reactions;
  double? lat;
  double? long;
  final Map<String, Color> avatar;

  CardWhispModel({
    required this.id,
    required this.username,
    required this.message,
    required this.createdAt,
    required this.reactions,
    required this.avatar,
    this.lat,
    this.long,
  });

  factory CardWhispModel.fromJson(Map<String, dynamic> json) {
    final avatarRaw = json['avatar'] as Map<String, dynamic>? ?? {};

    return CardWhispModel(
      id: json['id'] as int,
      username: json['username'] as String,
      message: json['message'] as String,
      createdAt: json['created_at'] as String,
      reactions: List<Map<String, int>>.from(json['reactions'] ?? []),
      avatar: avatarRaw.map(
        (key, value) => MapEntry(key, Color(int.parse(value, radix: 16))),
      ),
      lat: json['lat']?.toDouble(),
      long: json['long']?.toDouble(),
    );
  }

  bool get isThereLocation {
    return lat != null && long != null;
  }

  String get nearOrPublic {
    return isThereLocation ? "Near" : "Public";
  }

  Color get fontColor {
    return nearOrPublic == "Public" ? AppColors.blueText : AppColors.greenText2;
  }

  Color get backgroundColor {
    return nearOrPublic == "Public"
        ? AppColors.blueBackground2
        : AppColors.greenBackground2;
  }

  Color get borderColor {
    return nearOrPublic == "Public"
        ? AppColors.blueBorder
        : AppColors.greenText2.withValues(alpha: 0.5);
  }
}

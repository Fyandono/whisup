import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/widgets/text/text.dart';

class MyEmptyList extends StatelessWidget {
  const MyEmptyList({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 72, color: AppColors.greyText2),
          const SizedBox(height: 8),
          MyText(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          MyText(
            text: subtitle,
            fontSize: 14,
            color: AppColors.greyText2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

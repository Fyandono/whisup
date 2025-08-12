import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/widgets/highlight_text/highlight_text.dart';
import 'package:whisup/features/widgets/shimmer/shimmer.dart';

class MyWhispItemLoading extends StatelessWidget {
  const MyWhispItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final double width1 = 40 + random.nextInt(100).toDouble();
    final double width2 = 120 + random.nextInt(280).toDouble();
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyBorder.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(radius: 16, backgroundColor: AppColors.greyLoading),
              SizedBox(width: 6),
              MyShimmer(height: 13, width: width1),
              const Spacer(),
              MyShimmer(height: 13, width: 64),
              SizedBox(width: 6),
              MyHighlightText(
                text: "      ",
                fontColor: AppColors.greyLoading,
                backgroundColor: AppColors.greyLoading,
                borderColor: AppColors.greyLoading,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Message
          MyShimmer(height: 14, width: width2),
          const SizedBox(height: 12),

          // Reactions
          Wrap(
            spacing: 12,
            children: List.generate(1 + random.nextInt(2), (index) {
              final double chipWidth = 40 + random.nextInt(30).toDouble();
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.greyBackgrounReaction,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MyShimmer(height: 14, width: chipWidth),
              );
            }),
          ),
        ],
      ),
    );
  }
}

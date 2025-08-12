import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';

class MyShimmer extends StatelessWidget {
  final double height;
  final double width;

  const MyShimmer({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLoading,
        borderRadius: BorderRadius.circular(8),
      ),
      height: height * 1.15,
      width: width,
    );
  }
}

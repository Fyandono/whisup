import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/widgets/button/text_button.dart';

class MyBottomButton extends StatelessWidget {
  const MyBottomButton({
    required this.onPressed,
    required this.labelText,
    this.isOutline = false,
    this.isLoading = false,
    this.color,
    super.key,
  });

  final void Function()? onPressed;
  final String labelText;
  final bool isOutline;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyShadow,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          MyTextButton(
            style: isOutline ? buttonOutlined : buttonPrimaryBlue,
            isLoading: isLoading,
            onPressed: onPressed,
            text: labelText,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

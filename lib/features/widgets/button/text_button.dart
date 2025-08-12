import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/features/widgets/text/text.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final ButtonStyle style;
  final bool isLoading;

  const MyTextButton({
    this.text = "",
    required this.style,
    this.onPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color fontColor = AppColors.white;

    if (style == buttonPrimaryBlue || style == buttonPrimaryRed) {
      fontColor = AppColors.white;
    } else if (style == buttonPrimaryBlue2) {
      fontColor = AppColors.blueText2;
    } else if (style == buttonPrimaryRed2) {
      fontColor = AppColors.redText2;
    } else if (style == buttonPrimaryGreen2) {
      fontColor = AppColors.greenText2;
    } else {
      fontColor = AppColors.greyText;
    }

    if (onPressed == null) {
      fontColor = AppColors.white;
    }

    ButtonStyle buttonStyle() {
      if (onPressed == null && style == buttonOutlined) {
        fontColor = AppColors.white;
        return ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: const Size.fromHeight(42),
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
      } else {
        return style;
      }
    }

    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle(),
        child: isLoading
            ? Lottie.asset(
                'assets/json/loading.json',
                frameRate: FrameRate.max,
                filterQuality: FilterQuality.high,
              )
            : MyText(
                text: text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
      ),
    );
  }
}

final ButtonStyle buttonPrimaryBlue = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.blueBackground,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle buttonPrimaryBlue2 = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.blueBackground2,
  foregroundColor: AppColors.blueBackground2,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle buttonPrimaryRed = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.redBackground,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle buttonPrimaryRed2 = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.redBackground2,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle buttonPrimaryGreen2 = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.greenBackground2,
  foregroundColor: AppColors.greenBackground2,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle buttonOutlined = ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: const Size.fromHeight(42),
  padding: const EdgeInsets.symmetric(vertical: 12),
  backgroundColor: AppColors.white,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(
      color: AppColors.greyBorder,
    ), // Add border side
  ),
);

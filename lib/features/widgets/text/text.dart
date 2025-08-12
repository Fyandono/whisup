import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';

class MyText extends StatelessWidget {
  const MyText({
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.fontStyle,
    this.color = AppColors.greyText,
    this.textDecoration,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.maxLines,
    super.key,
  });
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        height: 1.15,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: textDecoration,
        decorationColor: color,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

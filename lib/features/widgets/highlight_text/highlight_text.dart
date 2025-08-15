import 'package:flutter/material.dart';
import 'package:whisup/features/widgets/text/text.dart';

class MyHighlightText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final Color? borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;

  const MyHighlightText({
    required this.text,
    required this.fontColor,
    required this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 6,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        // border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: MyText(
        text: text,
        fontSize: 10,
        color: fontColor,
        fontWeight: FontWeight.w500,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

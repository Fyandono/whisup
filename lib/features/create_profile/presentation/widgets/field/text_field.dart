import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whisup/const/colors.dart';

class MyTextField extends StatelessWidget {
  // controller
  final TextEditingController? controller;
  final String? initialValue;

  // configuration
  final FocusNode? focusNode;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;

  // validator
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  // keyboard
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  // styling
  final String label;
  final String? hint;
  final String? prefixText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool obscure;

  // methods
  final dynamic onTap;
  final Function(String?)? onChanged;
  final dynamic onTapSuffixIcon;
  final Function(String)? onFieldSubmitted;

  const MyTextField({
    // controller
    this.controller,
    this.initialValue,

    // configuration
    this.focusNode,
    this.enabled,

    // validator
    this.validator,
    this.autoValidateMode,
    this.maxLength,

    // keyboard
    this.inputAction,
    this.keyboardType,
    this.inputFormatters,

    // styling
    required this.label,
    this.hint,
    this.prefixText,
    this.maxLines,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.floatingLabelBehavior,

    // methods
    this.onTap,
    this.onChanged,
    this.onTapSuffixIcon,
    this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color? getColor() {
      return WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return AppColors.redText;
        } else if (states.contains(WidgetState.focused)) {
          return AppColors.blueText;
        } else {
          return AppColors.greyText2;
        }
      });
    }

    TextInputType? getKeyboardType() {
      if (onTap != null) {
        return TextInputType.none;
      } else if (keyboardType != null) {
        return keyboardType;
      } else {
        return null;
      }
    }

    return TextFormField(
      // controller
      controller: controller,
      initialValue: initialValue,

      // configuration
      readOnly: onTap != null ? true : false,
      obscureText: obscure,
      maxLines: maxLines ?? 1,
      enabled: enabled,
      focusNode: focusNode,
      maxLength: maxLength,

      // validator
      validator: validator,
      autovalidateMode: autoValidateMode,

      // keyboard
      enableInteractiveSelection: false,
      keyboardType: getKeyboardType(),
      textInputAction: inputAction,
      inputFormatters: inputFormatters,

      // methods
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(fontSize: 14),
      // styling
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 20,
              )
            : null,
        prefixIconColor: getColor(),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onTapSuffixIcon,
                child: Icon(
                  suffixIcon,
                  size: 20,
                ),
              )
            : null,
        suffixIconColor: getColor(),
        errorStyle: const TextStyle(color: AppColors.redText),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyBorder),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyBorder),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blueBorder),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redBorder),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redBorder),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.size,
    required this.onPressed,
    this.backgroundColor,
    this.border,
    this.textColor,
  });
  final String title;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? size;
  final BorderSide? border;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            fixedSize: size,
            backgroundColor: backgroundColor ?? Colors.white,
            shape: RoundedRectangleBorder(
                side: border ?? const BorderSide(color: AppColors.SECONDRY),
                borderRadius: BorderRadius.circular(8))),
        onPressed: onPressed,
        child: Text(title, style: titilliumBold.copyWith(color: textColor)));
  }
}

import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title, style: titilliumBold.copyWith(color: AppColors.PRIMARY)),
      TextSpan(
          text: " $value",
          style: titilliumSemiBold.copyWith(color: AppColors.BLACK)),
    ]));
  }
}

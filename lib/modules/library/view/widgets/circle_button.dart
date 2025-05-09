import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class CircleButton extends StatelessWidget {
  final String text;
  final Color primaryColor;
  final void Function() onTap;
  const CircleButton(
      {super.key,
      required this.text,
      required this.primaryColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 55.w,
        height: 55.w,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.LIGHTGRAY, width: 2),
            color: primaryColor,
            shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(text,
            style: titilliumBold.copyWith(
                color: AppColors.WHITE, fontSize: 12.sp)),
      ),
    );
  }
}

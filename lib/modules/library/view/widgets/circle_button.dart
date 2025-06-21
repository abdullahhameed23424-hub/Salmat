import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';

class BookButton extends StatelessWidget {
  final String text;
  final Color primaryColor;
  final void Function() onTap;
  const BookButton(
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
        height: 55.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.LIGHTGRAY, width: 2),
          borderRadius: BorderRadius.circular(30),
          color: primaryColor,
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: titilliumBold.copyWith(
                color: AppColors.WHITE, fontSize: 12.sp)),
      ),
    );
  }
}

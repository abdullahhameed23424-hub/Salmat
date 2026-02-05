import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';

class BookButton extends StatelessWidget {
  final String text;
  final Color primaryColor;
  final void Function()? onTap;
  final bool isEnabled;
  const BookButton(
      {super.key,
      required this.text,
      required this.primaryColor,
      this.onTap,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: SizedBox(
        height: 70.w,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.LIGHTGRAY, width: 2),
              borderRadius: BorderRadius.circular(30),
              color: isEnabled ? primaryColor : Colors.grey,
            ),
            alignment: Alignment.center,
            child: Text(text,
                style: titilliumBold.copyWith(
                    color: AppColors.WHITE, fontSize: 12.sp)),
          ),
        ),
      ),
    );
  }
}

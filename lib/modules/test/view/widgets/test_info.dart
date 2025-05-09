import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class TestInfo extends StatelessWidget {
  const TestInfo({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(text,
            style: titilliumBold.copyWith(
                fontSize: 14.sp, color: AppColors.DARK_BLUE)),
        const Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          width: 1.sw, // max width
          padding: EdgeInsets.symmetric(vertical: 8.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.DARK_BLUE, width: 1)),
          child: Text(
            value,
            style: titilliumRegular.copyWith(
                fontFamily: "bagel",
                fontSize: 18.sp,
                color: AppColors.DARK_BLUE),
          ),
        )
      ],
    );
  }
}

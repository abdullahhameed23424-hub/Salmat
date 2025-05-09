import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(Images.completedTestResult, width: 180.w),
        Positioned(
          bottom: 10.h,
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: titilliumSemiBold,
              ),
              SizedBox(height: 5.h),
              Text(
                value,
                style: titilliumBold.copyWith(
                    fontSize: 20.sp,
                    fontFamily: "nosifer",
                    color: AppColors.PRIMARY),
              )
            ],
          ),
        )
      ],
    );
  }
}

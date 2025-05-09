import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';

class UserSubjectCad extends StatelessWidget {
  const UserSubjectCad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: boxShadow),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.h),
            Image.asset(Images.arabic, width: 100.w),
            const Spacer(),
            Text(
              "اللغة العربية",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titilliumSemiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

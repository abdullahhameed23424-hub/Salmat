import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/test/view/screens/completed_test_details_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class CompletedTestCard extends StatelessWidget {
  const CompletedTestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
      child: InkWell(
        onTap: () {
          pushTo(context: context, toPage: const CompletedTestDetailsScreen());
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: AppColors.SECONDRY,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 5.h),
                SizedBox(
                  width: 110.w,
                  child: Image.asset(
                    Images.completedTest,
                    width: 110.w,
                  ),
                ),
                Text(
                  'أساسيات 1 في التحليل',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: titilliumBold.copyWith(
                      color: Colors.white, fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
              ],
            )),
      ),
    );
  }
}

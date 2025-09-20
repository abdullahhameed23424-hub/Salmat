import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/test/cubit/test_cubit.dart';
import 'package:salamat/modules/test/models/test.dart';
import 'package:salamat/modules/test/view/screens/completed_test_details_screen.dart';
import 'package:salamat/utils/global_functions.dart';

class CompletedTestCard extends StatelessWidget {
  const CompletedTestCard(
      {super.key, required this.test, required this.testCubit});
  final Test test;
  final TestCubit testCubit;
  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
      child: InkWell(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(80),
            topRight: Radius.circular(10)),
        onTap: () {
          pushTo(
              context: context,
              toPage:
                  CompletedTestDetailsScreen(test: test, testCubit: testCubit));
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
                  test.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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

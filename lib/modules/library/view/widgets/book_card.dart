import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/library/view/widgets/circle_button.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.primaryColor});
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return ZoomIn(
        delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
        child: Container(
          height: constrains.maxHeight,
          width: constrains.maxWidth,
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: boxShadow),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    width: constrains.maxWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      'اللغة الانكليزية',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titilliumBold.copyWith(
                          color: AppColors.WHITE, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 100.w,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        Images.siance, // replace with actual image path
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -30,
                width: constrains.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleButton(
                      onTap: () {},
                      text: 'تحميل',
                      primaryColor: primaryColor,
                    ),
                    CircleButton(
                      onTap: () {},
                      text: 'فتح',
                      primaryColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

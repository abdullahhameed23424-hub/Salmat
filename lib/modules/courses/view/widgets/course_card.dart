import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/utils/global_functions.dart';
import 'package:my_project_new/modules/courses/view/screens/course_details_screen.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.primaryColor});
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: const CourseDetailsScreen());
      },
      child: ZoomIn(
        delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(20),
              boxShadow: boxShadow),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CourseImage(imagePath: Images.course3),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 37.w),
                      child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "أشعة 2" * 10,
                          style: titilliumBold.copyWith(color: primaryColor)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _InfoItem(
                            label: translate('lessons', context),
                            value: "20",
                            primaryColor: primaryColor),
                        _InfoItem(
                            label: translate('hours', context),
                            value: "20",
                            primaryColor: primaryColor),
                        _EyeIcon(primaryColor: primaryColor),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CourseImage extends StatelessWidget {
  const CourseImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155.h,
      child: AspectRatio(
        aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _EyeIcon extends StatelessWidget {
  const _EyeIcon({required this.primaryColor});
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
      transform: Matrix4.translationValues(-8.w, -58.h, 0),
      child: Image.asset(Images.eye, width: 35.w),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem(
      {required this.label, required this.value, required this.primaryColor});

  final String label;
  final String value;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primaryColor,
          radius: 15.sp,
          child: Text(value,
              style: titilliumBold.copyWith(color: AppColors.WHITE)),
        ),
        SizedBox(width: 4.w),
        Text(label, style: titilliumSemiBold),
      ],
    );
  }
}

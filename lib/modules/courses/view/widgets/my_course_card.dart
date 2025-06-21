import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/modules/courses/models/course.dart';
import 'package:salamat/modules/courses/view/screens/course_details_screen.dart';
import 'package:salamat/utils/global_functions.dart';
import 'package:salamat/widgets/cached_image.dart';

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    super.key,
    required this.course,
  });

  final Course course;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: CourseDetailsScreen(course: course));
      },
      child: ZoomIn(
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
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.GRAY),
                width: 130.w,
                child: AspectRatio(
                    aspectRatio: 1, child: CachedImage(image: course.image)),
              ),
              const Spacer(),
              Text(
                course.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titilliumSemiBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

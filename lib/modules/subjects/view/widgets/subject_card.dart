import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/modules/courses/view/screens/courses_screen.dart';
import 'package:my_project_new/modules/subjects/models/subject.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/utils/global_functions.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard(
      {super.key, required this.primaryColor, required this.subject});
  final Color primaryColor;
  final Subject subject;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: CoursesScreen(subject: subject));
      },
      child: ZoomIn(
        delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(
                  subject.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumBold.copyWith(
                      fontSize: 14.sp, color: AppColors.WHITE),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedImage(
                          image: subject.image,
                          boxFit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

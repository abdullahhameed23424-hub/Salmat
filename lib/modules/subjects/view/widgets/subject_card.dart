import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart'; 
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/courses/view/screens/courses_screen.dart';
import 'package:my_project_new/modules/subjects/models/subject.dart';
import 'package:my_project_new/widgets/cached_image.dart';
import 'package:my_project_new/widgets/custom_button.dart';
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
        pushTo(context: context, toPage:   CoursesScreen(subject: subject ));
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
          padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  subject.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumBold.copyWith(
                      fontSize: 14.sp, color: AppColors.WHITE),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.5.w),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                     subject.courseCount.toString(),
                      style: titilliumBold.copyWith(color: AppColors.WHITE),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(translate('course', context), style: titilliumBold.copyWith(fontSize: 14.sp)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 0.h),
                    transform: Matrix4.translationValues(0, 22.h, 0),
                    height: 40.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: AppColors.LIGHTGRAY,
                        boxShadow: boxShadow,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )),
                    child: Container(
                      transform: Matrix4.translationValues(0, 8.h, 0),
                      decoration: BoxDecoration(
                          boxShadow: boxShadow,
                          color: AppColors.LIGHTGRAY,
                          borderRadius: BorderRadius.circular(20)),
                      child: CustomButton(
                        buttonStyle: titilliumBold.copyWith(
                            fontSize: 12.sp, color: AppColors.WHITE),
                        padding: EdgeInsets.symmetric(horizontal: 7.55.w),
                        size: Size(70.w, 45.h),
                        label: translate('details', context),
                        backgroundColor: primaryColor,
                        onPressed: () {
                          pushTo(
                              context: context, toPage:   CoursesScreen(subject: subject ));
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 85.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedImage(image:   subject.image)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:my_project_new/modules/lessons/view/screens/lesson_details_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
    required this.index,
  });

  final Lesson lesson;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: LessonDetailsScreen(lesson: lesson));
      },
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42.w,
                height: 28.h,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 1.8),
                        blurRadius: 3,
                        spreadRadius: 0)
                  ],
                  color: AppColors.DARK_GREY,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(18)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 28.h,
                decoration: const BoxDecoration(
                    color: AppColors.DARK_GREY,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Container(
                  height: 28.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.LIGHTGRAY),
                  child: Text(
                    "${translate("lesson", context)} ${index + 1}",
                    style: titilliumBold.copyWith(color: AppColors.PRIMARY),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: 28.h,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-2, 2),
                        blurRadius: 3,
                        spreadRadius: 0)
                  ],
                  color: AppColors.DARK_GREY,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
              ))
            ],
          ),
          Container(
            height: 75.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: const BoxDecoration(
              color: AppColors.DARK_GREY,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(Images.lessonIcon, width: 40.w),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 1.sw - 116.w, //1.sw - 40.w - 12.w - (16 * 4).w,
                  child: Text(
                    //////////////////////////// total width , 40 :for image width  and  12.w , 16.w is padding  ,  : 1.sw - 40.w - 12.w - (16 * 4).w,
                    lesson.name,
                    maxLines: 2,
                    style: titilliumSemiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

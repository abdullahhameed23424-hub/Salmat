import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/images.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/lessons/models/lesson.dart';

class LessonCard extends StatelessWidget {
  const LessonCard(
      {super.key,
      required this.lesson,
      required this.onTap,
      required this.index});

  final Lesson lesson;
  final int index;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.PRIMARY,
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42.w,
                height: 35.h,
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
                height: 35.h,
                decoration: const BoxDecoration(
                    color: AppColors.DARK_GREY,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Container(
                  height: 35.h,
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
                height: 35.h,
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
            height: 85.h,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Image.asset(Images.lessonIcon, width: 40.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        lesson.name,
                        maxLines: 2,
                        style: titilliumSemiBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      lesson.isOpen
                          ? Icons.lock_open_rounded
                          : Icons.lock_rounded,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // if(lesson.quized == true||lesson.attachmentCount > 0)
                      //   const Text("يوجد ",style: TextStyle(fontSize: 12),),
                      if (lesson.quized == true)
                        const Text(
                          "+اختبار",
                          style: TextStyle(
                            color: AppColors.DARK_GRAY,
                          ),
                        ),
                      if (lesson.quized == true && lesson.attachmentCount > 0)
                        const Text(" "),
                      if (lesson.attachmentCount > 0)
                        Text("+${lesson.attachmentCount} ملف مرفق",
                            style: const TextStyle(color: AppColors.DARK_GRAY))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

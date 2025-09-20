import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/constant/public_constant.dart';
import 'package:salamat/localization/language_constrants.dart';
import 'package:salamat/modules/teachers/models/teacher.dart';
import 'package:salamat/modules/teachers/view/screens/teacher_details_screen.dart';
import 'package:salamat/widgets/cached_image.dart';
import 'package:salamat/widgets/custom_button.dart';
import 'package:salamat/utils/global_functions.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    super.key,
    required this.teacher,
  });
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(
            context: context,
            toPage: TeacherDetailsScreen(teacherId: teacher.id));
      },
      child: FadeInRight(
        delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
        child: Container(
            height: 160.h,
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 25.h),
            decoration: BoxDecoration(
                color: AppColors.WHITE,
                boxShadow: boxShadow,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              spacing: 15.w,
              children: <Widget>[
                Align(
                  child: SizedBox(
                    width: 120.w,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10)),
                          child: CachedImage(
                            borderRadius: BorderRadius.circular(10),
                            image: teacher.image,
                            boxFit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
                Expanded(
                    child: Column(
                  spacing: 5,
                  children: <Widget>[
                    Text(
                      teacher.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titilliumBold.copyWith(
                          color: AppColors.PRIMARY,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.PRIMARY),
                    ),
                    Text(teacher.description,
                        maxLines: 2,
                        style: titilliumRegular.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center),
                    const Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        height: 42.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: AppColors.LIGHTGRAY,
                            borderRadius: BorderRadius.circular(20)),
                        transform: Matrix4.translationValues(
                            Localizations.localeOf(context).languageCode == "ar"
                                ? 10.w
                                : -10,
                            10.h,
                            0),
                        child: CustomButton(
                            disabledBackgroundColor: AppColors.PRIMARY,
                            size: Size(140.w, 40.h),
                            padding: EdgeInsets.all(6.w),
                            buttonStyle: titilliumBold.copyWith(
                                fontSize: 14.sp, color: AppColors.WHITE),
                            label: translate('details', context),
                            onPressed: null),
                      ),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}

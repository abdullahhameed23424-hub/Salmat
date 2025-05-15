import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/courses/models/unit.dart';
import 'package:my_project_new/modules/lessons/view/screens/lessonss_screen.dart';
import 'package:my_project_new/utils/global_functions.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    super.key,
    required this.unit,
  });
  final Unit unit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: const LessonsScreen());
        return;
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  backgroundColor: AppColors.WHITE,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Image.asset(
                          Images.cantOpenUnit,
                          width: 320.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            translate('cannot_open_unit', context),
                            style: titilliumBold.copyWith(fontSize: 14.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
      child: FadeIn(
        duration: const Duration(milliseconds: 400),
        delay: Duration(milliseconds: 100 * (1 + Random().nextInt(5))),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 55.h,
          width: 1.sw,
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Image.asset(true ? Images.unlockedUnit : Images.lockedUnit,
                  width: 24.w),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  unit.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleRegular,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(Images.unitIcon, width: 42.w),
              )
            ],
          ),
        ),
      ),
    );
  }
}

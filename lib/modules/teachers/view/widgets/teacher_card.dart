import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/constant/public_constant.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/teachers/view/screens/teacher_details_screen.dart';
import 'package:my_project_new/widgets/custom_button.dart';
import 'package:my_project_new/utils/global_functions.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushTo(context: context, toPage: const TeacherDetailsScreen());
      },
      child: FadeInRight(
        delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
        child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 25.h),
            decoration: BoxDecoration(
                color: AppColors.WHITE,
                boxShadow: boxShadow,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              spacing: 15.w,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 100.w,
                    child: AspectRatio(
                        aspectRatio: 12.5 / 17,
                        child: ClipRRect(
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10)),
                          child: Image.asset(
                            Images.trainer,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
                Expanded(
                    child: Column(
                  spacing: 5,
                  children: <Widget>[
                    Text(
                      ' أ. مهند عامر' * 2,
                      style: titilliumBold.copyWith(
                          color: AppColors.PRIMARY,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.PRIMARY),
                    ),
                    Text('حاصل على إجازة في الرياضيات من جامعة دمشق ' * 5,
                        maxLines: 2,
                        style: titilliumRegular.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center),
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
                            20.h,
                            0),
                        child: CustomButton(
                          size: Size(140.w, 40.h),
                          padding: EdgeInsets.all(6.w),
                          buttonStyle: titilliumBold.copyWith(
                              fontSize: 14.sp, color: AppColors.WHITE),
                          label: translate('details', context),
                          onPressed: () {},
                        ),
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

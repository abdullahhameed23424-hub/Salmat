import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';

class LessonButtonsTabbar extends StatelessWidget {
  const LessonButtonsTabbar({
    super.key,
    required this.controller,
    required this.items,
    required this.onTap,
  });

  final TabController controller;
  final List<String> items;
  final void Function(int index) onTap;
  @override
  Widget build(context) {
    return Container(
        padding: EdgeInsets.only(
          bottom: 15.h,
        ),
        child: ButtonsTabBar(
          controller: controller,
          onTap: (index) {
            onTap(index);
          },
          backgroundColor: AppColors.SECONDRY,
          unselectedBackgroundColor: AppColors.LIGHTGRAY,
          contentPadding: EdgeInsets.symmetric(horizontal: 40.w),
          physics: const NeverScrollableScrollPhysics(),
          unselectedLabelStyle:
              titilliumRegular.copyWith(color: AppColors.BLACK),
          labelStyle: titilliumBold.copyWith(color: AppColors.WHITE),
          labelSpacing: 50,
          tabs: List.generate(
            items.length,
            (index) => Tab(
              text: translate(items[index], context),
            ),
          ),
        ));
  }
}

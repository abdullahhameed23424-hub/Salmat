import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';

import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/constant/dimensions.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.appBarBorderRadius,
  });
  final String title;
  final BorderRadiusGeometry? appBarBorderRadius;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
          borderRadius: appBarBorderRadius ??
              const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
      backgroundColor: AppColors.SECONDRY,
      surfaceTintColor: Colors.transparent,
      shadowColor: appBarBorderRadius == null ? AppColors.BLACK : null,
      title: Text(
        title,
        style: titilliumBold.copyWith(
            color: AppColors.WHITE, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      ),
      centerTitle: true,
      leading: IconButton(
          style: IconButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(32, 32),
              backgroundColor: Colors.white24,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25.sp,
            color: AppColors.WHITE,
          )),
    );
  }
}

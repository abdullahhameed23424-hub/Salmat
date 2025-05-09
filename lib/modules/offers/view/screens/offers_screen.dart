import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/widgets/app_scaffold.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: translate("offers", context),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 10.w,
          horizontal: 12.h,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(height: 8.h),
        itemBuilder: (context, index) => ZoomIn(
            delay: Duration(milliseconds: 50 + 50 * Random().nextInt(6)),
            child: Image.asset(Images.offer)),
      ),
    );
  }
}

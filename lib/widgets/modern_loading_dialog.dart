import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

import 'dart:ui';

import 'package:my_project_new/localization/language_constrants.dart';

class ModernLoadingDialog extends StatefulWidget {
  const ModernLoadingDialog({super.key});

  static void show(
      BuildContext context, GlobalKey<ModernLoadingDialogState> key) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ModernLoadingDialog(
        key: key,
      ),
    );
  }

  @override
  State<ModernLoadingDialog> createState() => ModernLoadingDialogState();
}

class ModernLoadingDialogState extends State<ModernLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.PRIMARY,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                translate('waiting', context),
                textAlign: TextAlign.center,
                style: titilliumBold.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

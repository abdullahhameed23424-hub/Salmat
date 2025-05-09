// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class ConfirmationDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(17.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.PRIMARY),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.LIGHT_BLUE,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.SECONDRY, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "Your request has been received, you will be notified of the result soon.",
                    textAlign: TextAlign.center,
                    style: titleHeader.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                    backgroundColor: AppColors.LIGHT_BLUE,
                    size: Size(145.w, 50.h),
                    label: "OK",
                    onPressed: () {
                      // pu
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/localization/language_constrants.dart';
import 'package:my_project_new/modules/test/models/result.dart';
import 'package:my_project_new/widgets/custom_button.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({
    super.key,
    required this.result,
    required this.onTryAgainInFailed,
  });

  final Result result;
  final void Function() onTryAgainInFailed;
  static void show(BuildContext context,
      {required Result result, required void Function() onTryAgainInFailed}) {
    showDialog(
      context: context,
      builder: (_) =>
          ResultDialog(result: result, onTryAgainInFailed: onTryAgainInFailed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElasticIn(
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: result.pass == true
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  result.pass == true ? Icons.check_circle : Icons.cancel,
                  color: AppColors.WHITE,
                  size: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              result.pass == true
                  ? translate('passed', context)
                  : translate('failed', context),
              style: titilliumBold.copyWith(
                color: result.pass == true ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20.h),
            _buildRow(translate('exam_degree', context), result.examDegree),
            _buildRow(
                translate('your_score', context), result.examStudentDegree),
            _buildRow(translate('pass_percentage', context),
                '${result.examPassPercentage}%'),
            SizedBox(height: 24.h),
            if (result.pass != true)
              CustomButton(
                  borderRadius: BorderRadius.circular(12.r),
                  label: translate('try_again', context),
                  onPressed: () {
                    onTryAgainInFailed();
                  }),
            SizedBox(height: 16.h),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              label: translate('close', context),
              backgroundColor: AppColors.WHITE,
              buttonStyle: titilliumBold.copyWith(color: AppColors.PRIMARY),
              borderRadius: BorderRadius.circular(12.r),
              border: const BorderSide(color: AppColors.PRIMARY),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:", style: titilliumRegular),
          Text(value,
              style: titilliumBold.copyWith(
                  color: AppColors.PRIMARY, fontSize: 16.sp)),
        ],
      ),
    );
  }
}

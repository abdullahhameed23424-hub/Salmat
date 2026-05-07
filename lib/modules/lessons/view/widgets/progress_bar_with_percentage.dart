import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/modules/downloads/download/bloc_v2/download_cubit.dart';

class ProgressBarWithPercentage extends StatelessWidget {
  const ProgressBarWithPercentage({
    super.key,
    required this.cubit,
  });

  final DownloadCubit2 cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// [PROGRESS_BAR]
        LinearProgressIndicator(
          value: cubit.progress / 100,
          color: AppColors.PRIMARY,
          backgroundColor: AppColors.PRIMARY.withValues(alpha: 0.2),
          minHeight: 6.h,
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(height: 4.h),

        /// [PERCENTAGE]
        Text(
          '${cubit.progress.toInt()}%',
          style: titilliumRegular.copyWith(fontSize: 10.sp),
        ),
      ],
    );
  }
}

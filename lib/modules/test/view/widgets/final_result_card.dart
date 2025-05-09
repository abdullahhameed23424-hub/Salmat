import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class FinalResultCard extends StatelessWidget {
  final double score;

  const FinalResultCard({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ZoomIn(
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text('النتيجة النهائية', style: titilliumBold),
                ),
              ),
              Container(
                width: 100.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: score < 60
                      ? AppColors.PURPLE_LIGHT
                      : AppColors.LIGHT_GREEN,
                  borderRadius: BorderRadiusDirectional.horizontal(
                    end: Radius.circular(15.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  score.toStringAsFixed(2),
                  style: titilliumBold.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

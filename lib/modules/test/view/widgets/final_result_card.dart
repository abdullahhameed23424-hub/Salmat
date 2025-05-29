import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';
import 'package:my_project_new/modules/test/models/result.dart';

class FinalResultCard extends StatelessWidget {
  final Result result;
  const FinalResultCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: double.infinity,
              decoration: BoxDecoration(
                color: result.pass == true
                    ? AppColors.LIGHT_GREEN
                    : AppColors.PURPLE_LIGHT,
                borderRadius: BorderRadiusDirectional.horizontal(
                  end: Radius.circular(15.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "${result.examStudentDegree} / ${result.examDegree}",
                style: titilliumBold.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

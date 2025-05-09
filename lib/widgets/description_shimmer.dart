import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  
import 'package:my_project_new/widgets/app_shimmer.dart';
 
class DescriptionShimmer extends StatelessWidget {
  const DescriptionShimmer({
    super.key,
    required this.linesNumber,
  });
  final int linesNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          linesNumber,
          (index) => AppShimmer(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 7.h),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(2)),
              height: 10,
              width: 1.sw - (index * 70.w),
            ),
          ),
        ),
      ),
    );
  }
}

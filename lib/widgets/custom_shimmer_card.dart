import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/widgets/app_shimmer.dart';

class CustomShimmerCard extends StatelessWidget {
  const CustomShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.SECONDRY, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
              child: AppShimmer(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
          )),
          AppShimmer(
            baseColor: Colors.grey[400],
            child: Container(
              height: 4.h,
              width: 50.w,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

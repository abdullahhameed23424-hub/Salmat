import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_project_new/constant/app_colors.dart'; 

class PageLoading extends StatelessWidget {
  const PageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
       
        child:
            LoadingAnimationWidget.fourRotatingDots(
                color: AppColors.PRIMARY, size: 30.sp   ));
  }
}

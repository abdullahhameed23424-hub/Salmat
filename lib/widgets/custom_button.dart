import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback ?onPressed;
  final TextStyle? buttonStyle;
  final Size? size;
  final Color? backgroundColor;
  final BorderSide? border;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? disabledBackgroundColor;
  
  const CustomButton({  
    this.disabledBackgroundColor,
    super.key,
    required this.label,
    this.buttonStyle,
    this.padding,
    this.size,
    required this.onPressed,
    this.borderRadius,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      
      style: ElevatedButton.styleFrom(
        elevation: 2,
        disabledBackgroundColor: disabledBackgroundColor  ,
        minimumSize: size ?? Size(0.92.sw, 60.h),
        backgroundColor: backgroundColor ?? AppColors.PRIMARY,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          side: border ?? BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
      ),
      child: Text(
        textAlign: TextAlign.center,
        label,
        style: buttonStyle ?? titilliumBold.copyWith(color: AppColors.WHITE),
      ),
    );
  }
}

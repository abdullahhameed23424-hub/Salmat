import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project_new/constant/custom_themes.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({super.key, 
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 24.sp),
      SizedBox(width: 3.w),
      Text(text, style: titilliumRegular),
      const Spacer(),
    ]);
  }
}

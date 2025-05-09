import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';

class BlueCircle extends StatelessWidget {
  const BlueCircle({super.key, required this.diagram});
  final double diagram;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: diagram,
      height: diagram,
      decoration: const BoxDecoration(
        color: AppColors.SECONDRY,
        shape: BoxShape.circle,
      ),
    );
  }
}

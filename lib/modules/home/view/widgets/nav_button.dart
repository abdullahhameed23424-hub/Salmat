import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/custom_themes.dart';
import 'package:salamat/localization/language_constrants.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.icons,
    required this.page,
    required this.index,
  });

  final List icons;
  final int page;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          icons[index]['icon'],
          width: 32.w,
          color: page == index ? AppColors.PRIMARY : AppColors.WHITE,
        ),
        if (page != index)
          Text(
            translate(icons[index]['title'], context),
            style: titilliumRegular.copyWith(
              color: page == index ? AppColors.BLACK : AppColors.WHITE,
            ),
          )
      ],
    );
  }
}

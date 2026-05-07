// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:salamat/constant/app_colors.dart';
import 'package:salamat/constant/dimensions.dart';

const String FONTF_FAMILY = 'NotoKufiArabic';
final TextStyle titilliumRegular = TextStyle(
    fontFamily: FONTF_FAMILY,
    fontSize: Dimensions.FONT_SIZE_SMALL,
    color: AppColors.LOGO_PRIMARY);
final TextStyle regularSemiBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  color: AppColors.LOGO_PRIMARY,
  fontSize: Dimensions.FONT_SIZE_SMALL,
);

final TextStyle titleRegular = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontWeight: FontWeight.w500,
  color: AppColors.LOGO_PRIMARY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);
final TextStyle titleHeader = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontWeight: FontWeight.w600,
  color: AppColors.LOGO_PRIMARY,
  fontSize: Dimensions.FONT_SIZE_LARGE,
);
final TextStyle titilliumSemiBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);

final TextStyle titilliumBold = TextStyle(
  fontFamily: FONTF_FAMILY,
  color: AppColors.LOGO_PRIMARY,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);
